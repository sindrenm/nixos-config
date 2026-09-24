#!/usr/bin/env nu

# Updates overlays/android-studio-canary.nix to the latest Android Studio canary release.
#
# Reads the same release feed JetBrains Toolbox and nixpkgs' own android-studio updater use, picks
# the highest-versioned Canary entry, and rewrites the version, url and sha256Hash in place. The
# feed ships the sha256 of every artifact, so nothing has to be downloaded to update the pin.
#
# Exits 0 whether or not anything changed; check `git diff` to find out. When running under GitHub
# Actions, `version`, `name` and `updated` are also written to $GITHUB_OUTPUT.
#
# Exits > 0 on errors.

const RELEASES_URL = "https://jb.gg/android-studio-releases-list.json"

let overlay = $env.CURRENT_FILE
| path dirname --num-levels 2
| path join overlays android-studio-canary.nix

let releases = http get $RELEASES_URL

# The highest-versioned Canary entry, sorted the same way nixpkgs' own updater does.
let canary = $releases.content.item
| where channel == Canary
| sort-by version -n
| last

let linux_artifact = $canary.download
| where {|d| $d.link | str ends-with "-linux.tar.gz" }
| first

let version = $canary.version
let name = $canary.name
let url = $linux_artifact.link
let sha256_hash = $linux_artifact.checksum

# Prints the `msg` to stderr and exits with status code 1
def fail [msg: string] {
  print --stderr $msg
  exit 1
}

for field in (
  {
    version: $version
    name: $name
    url: $url
    sha256_hash: $sha256_hash
  } | transpose key value
) {
  if ($field.value | is-empty) {
    fail $"could not read ($field.key) from ($RELEASES_URL)"
  }
}

if not ($url | str starts-with "https://edgedl.me.gvt1.com/android/studio/") {
  fail $"url '($url)' had an unexpected value, maybe the server changed?"
}

if not ($sha256_hash =~ '^[0-9a-f]{64}$') {
  fail $"checksum '($sha256_hash)' is not a sha256 hex digest, maybe the feed changed?"
}

let current = open $overlay
| parse --regex 'version = "(?<version>[^"]*)"'
| get version.0

if $current == $version {
  print $"android-studio canary is already up to date at ($version)"

  if "GITHUB_OUTPUT" in $env {
    $"updated=false\n" | save --append $env.GITHUB_OUTPUT
    $"version=($version)\n" | save --append $env.GITHUB_OUTPUT
    $"name=($name)\n" | save --append $env.GITHUB_OUTPUT
  }

  exit 0
}

# The overlay interpolates ${version} into the url, so put the placeholder back where the literal
# version appears. Only the path segment carries it; the filename uses a separate release codename.
let url_template = $url | str replace --all $"/($version)/" ("/" + '${version}' + "/")

try {
  http head $url
} catch {
  fail $"($url) is not reachable, stopping update"
}

let updated = (
  open $overlay
  | lines
  | each {|line|
      if ($line | str starts-with "  version = ") {
        $"  version = \"($version)\"; # \"($name)\""
      } else if ($line | str starts-with "      url = ") {
        $"      url = \"($url_template)\";"
      } else if ($line | str starts-with "      sha256Hash = ") {
        $"      sha256Hash = \"($sha256_hash)\";"
      } else {
        $line
      }
    }
  | str join "\n"
)

$"($updated)\n" | save --force $overlay

print $"updated android-studio canary from ($current) to ($version) \(($name)\)"

if "GITHUB_OUTPUT" in $env {
  "updated=true\n" | save --append $env.GITHUB_OUTPUT
  $"version=($version)\n" | save --append $env.GITHUB_OUTPUT
  $"name=($name)\n" | save --append $env.GITHUB_OUTPUT
}

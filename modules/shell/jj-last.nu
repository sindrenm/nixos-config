# `jj log` shorthand that lists the last n commits in the optionally provided `--revset`.
#
# Created as a Nushell function instead of a `jj` alias to more easily support default values.
def "jj last" [
  n: int = 10 # number of revisions to show
  --revset (-r): string = "::@" # revset to log, defaults to ancestors of the working copy
] {
  jj log -r $revset --limit $n
}

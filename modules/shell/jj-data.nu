# Structured-data variants of various `jj` list/log commands.
#
# `jj`'s default output is human-readable, so these functions instead ask for JSON through custom `--template`s, and
# then parse that with `from json`. Results are returned as proper Nushell tables, allowing further piping through
# `where`, `first`, sort-by`, etc.`.

const JJ_REF_TEMPLATE = 'surround("{", "}\n", join(",",
  json("name") ++ ":" ++ json(name),
  json("description") ++ ":" ++ if (normal_target, json(normal_target.description().first_line()), "null"),
  json("change_id") ++ ":" ++ if (normal_target, json(normal_target.change_id()), "null"),
))'

# `jj bookmark list`, as a Nushell table of records.
def "jj bookmarks" [
  ...names: string # only bookmarks whose name matches (glob/string pattern)
  --all-remotes (-a) # include synced/untracked remote bookmarks too
  --remote: string # only bookmarks on this remote
  --revision (-r): string # only bookmarks whose local target is in this revset
] {
  mut flags = []

  if $all_remotes { $flags = ($flags | append "--all-remotes") }
  if $remote != null { $flags = ($flags | append ["--remote" $remote]) }
  if $revision != null { $flags = ($flags | append ["--revision" $revision]) }

  jj bookmark list --template $JJ_REF_TEMPLATE ...$flags ...$names
  | from json -o
  | uniq #
}

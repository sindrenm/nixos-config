#!/usr/bin/env nu

# Noctalia's own screenshot service (screenshot-region/screenshot-fullscreen) covers area and monitor capture. This
# script only handles windows, which Noctalia has no dedicated mode for.
#
# https://github.com/noctalia-dev/noctalia/issues/3380
#
# Feeding every visible window's geometry to `slurp -r` turns it into a window picker: hovering highlights a window,
# clicking captures it. Beats silently grabbing whatever happened to be focused when the keybind fired.

let dir = ([$nu.home-dir pictures screenshots] | path join)
mkdir $dir

# Matches Noctalia's `shell.screenshot.filename_pattern`, so window shots sort alongside its region/monitor ones.
let filepath = ([$dir $"screenshot_(date now | format date '%Y-%m-%d_%H:%M:%S').png"] | path join)

let boxes = (
  mmsg get all-clients
  | from json
  | get clients
  | where {|w| $w.is_visible and (not $w.is_minimized) }
  | each {|w| $"($w.x),($w.y) ($w.width)x($w.height)" }
)

if ($boxes | is-empty) {
  exit 1
}

# slurp exits non-zero when the selection is cancelled (Escape / right click), which is not an error worth reporting.
let geometry = (try { $boxes | to text | slurp -r } catch { exit 0 })

grim -g $geometry $filepath
open --raw $filepath | wl-copy

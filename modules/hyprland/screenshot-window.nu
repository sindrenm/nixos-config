#!/usr/bin/env nu

# Like the Mango picker: click a visible window, save it, and copy it to the clipboard.
let monitors = hyprctl -j monitors | from json
let clients = hyprctl -j clients | from json
let boxes = $monitors | each {|m|
  let workspace = if $m.specialWorkspace.id != 0 { $m.specialWorkspace.id } else { $m.activeWorkspace.id }
  let rotated = ($m.transform mod 2) == 1
  let width = (if $rotated { $m.height } else { $m.width }) / $m.scale
  let height = (if $rotated { $m.width } else { $m.height }) / $m.scale

  $clients
  | where {|w| $w.mapped and (not $w.hidden) and ($w.monitor == $m.id) and ($w.pinned or $w.workspace.id == $workspace) }
  | each {|w|
    # Scrolling windows may extend beyond the monitor: only offer their visible portion.
    let x = [$w.at.0 $m.x] | math max
    let y = [$w.at.1 $m.y] | math max
    let right = [($w.at.0 + $w.size.0) ($m.x + $width)] | math min
    let bottom = [($w.at.1 + $w.size.1) ($m.y + $height)] | math min
    if $right > $x and $bottom > $y {
      $"($x | into int),($y | into int) (($right - $x) | into int)x(($bottom - $y) | into int)"
    }
  }
  | compact
} | flatten

if ($boxes | is-empty) { exit 1 }

let geometry = try { $boxes | to text | slurp -r } catch { exit 0 }
let dir = [$nu.home-dir pictures screenshots] | path join
mkdir $dir
let filepath = [$dir $"screenshot_(date now | format date '%Y-%m-%d_%H:%M:%S').png"] | path join
grim -g $geometry $filepath
open --raw $filepath | wl-copy

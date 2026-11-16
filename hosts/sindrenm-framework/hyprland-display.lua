require("laptop-display").setup({ scale = 1.5 })

-- Variable refresh rate lets the 120 Hz panel drop its refresh rate on static content to save power. Set globally
-- since the per-monitor `vrr` field in hl.monitor() has no effect; only eDP-1 is VRR-capable anyway.
hl.config({ misc = { vrr = 1 } })

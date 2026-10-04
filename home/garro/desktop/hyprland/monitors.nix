''
  ------------------
  ---- MONITORS ----
  ------------------

  -- Generic fallback for external monitors
  hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
  })

  -- Internal laptop display
  hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "0x0",
    scale = 1,
  })

  -- HDMI output extends the internal display (static - no mirroring,
  -- no reactive dock/undock switching).
  -- Pinned to 1920x1080: "preferred" picked a mode on the TV that
  -- negotiated a wrong color range/space, producing a violet tint.
  -- Explicit position (not "auto"): flush against eDP-1's right edge
  -- (eDP-1 is 1366 wide) - non-overlapping, but still contiguous so the
  -- cursor can actually move across between them.
  hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    position = "1366x0",
  })
''

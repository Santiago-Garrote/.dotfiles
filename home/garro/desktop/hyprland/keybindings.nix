''
  ----------------------
  ---- APPLICATIONS ----
  ----------------------

  local terminal = "kitty"
  local menu = "hyprlauncher"

  ---------------------
  ---- KEYBINDINGS ----
  ---------------------

  local mainMod = "SUPER"

  hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
  hl.bind(mainMod .. " + C", hl.dsp.window.close())
  hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
  hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
  hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("power-menu"))
  hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
  hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("sh -c 'grim -g \"$(slurp)\" - | wl-copy'"))
  hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
  hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
  hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
  hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
  hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
  hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
  hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

  -- Workspace navigation
  for i = 1, 10 do
    local key = tostring(i % 10)
    local ws = tostring(i)

    hl.bind(mainMod .. "+" .. key, hl.dsp.focus({ workspace = ws, on_current_monitor = true}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }))
  end
''

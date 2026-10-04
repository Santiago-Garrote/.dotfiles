''
  -- Short, mechanical motion profile
  hl.curve("mechanical", {
    type = "bezier",
    points = {
      { 0.20, 0.00 },
      { 0.00, 1.00 },
    },
  })

  hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 1.6,
    bezier = "mechanical",
    style = "popin 98%",
  })

  hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 1.2,
    bezier = "mechanical",
  })

  hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 1.4,
    bezier = "mechanical",
    style = "fade",
  })

  hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 1.2,
    bezier = "mechanical",
  })

  hl.animation({
    leaf = "border",
    enabled = true,
    speed = 1.0,
    bezier = "mechanical",
  })

  hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 2.0,
    bezier = "mechanical",
    style = "slidefade 8%",
  })
''

return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 18,
  height = 10,
  tilewidth = 64,
  tileheight = 64,
  properties = {},
  tilesets = {
    {
      name = "tiles_sheet_1",
      firstgid = 1,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../sheets/tiles_sheet_1.png",
      imagewidth = 256,
      imageheight = 64,
      properties = {},
      tiles = {}
    },
    {
      name = "tiles_background",
      firstgid = 5,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../sheets/tiles_background.png",
      imagewidth = 1024,
      imageheight = 1024,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "background",
      x = 0,
      y = 0,
      width = 18,
      height = 10,
      visible = true,
      opacity = 1,
      properties = {
        ["parallax_x"] = "0.3",
        ["sheet"] = "tiles_background"
      },
      encoding = "lua",
      data = {
        133, 134, 135, 136, 137, 138, 139, 140, 133, 134, 135, 136, 137, 138, 139, 140, 133, 134,
        149, 150, 151, 152, 153, 154, 155, 156, 149, 150, 151, 152, 153, 154, 155, 156, 149, 150,
        165, 166, 167, 168, 169, 170, 171, 172, 165, 166, 167, 168, 169, 170, 171, 172, 165, 166,
        181, 182, 183, 184, 185, 186, 187, 188, 181, 182, 183, 184, 185, 186, 187, 188, 181, 182,
        133, 198, 199, 200, 201, 202, 203, 204, 197, 198, 199, 200, 201, 202, 203, 204, 197, 198,
        213, 214, 215, 216, 217, 218, 219, 220, 213, 214, 215, 216, 217, 218, 219, 220, 213, 214,
        229, 230, 231, 232, 233, 234, 235, 236, 229, 230, 231, 232, 233, 234, 235, 236, 229, 230,
        245, 246, 247, 248, 249, 250, 251, 252, 245, 246, 247, 248, 249, 250, 251, 252, 245, 246,
        133, 134, 135, 136, 137, 138, 139, 140, 133, 134, 135, 136, 137, 138, 139, 140, 133, 134,
        149, 150, 151, 152, 153, 154, 155, 156, 149, 150, 151, 152, 153, 154, 155, 156, 149, 150
      }
    },
    {
      type = "objectgroup",
      name = "objects",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 256,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 320,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 384,
          y = 192,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 448,
          y = 192,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 512,
          y = 192,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 512,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 576,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 576,
          y = 192,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 640,
          y = 192,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 704,
          y = 192,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 768,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 832,
          y = 64,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 384,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 448,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 512,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 576,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 640,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 768,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 704,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 576,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 832,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 512,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 320,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick1",
          shape = "rectangle",
          x = 256,
          y = 512,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "scissors",
          shape = "polyline",
          x = 6,
          y = 485,
          width = 0,
          height = 0,
          visible = true,
          polyline = {
            { x = 176, y = 26 },
            { x = 284, y = -180 },
            { x = 105, y = -403 },
            { x = 41, y = -130 },
            { x = 110, y = 104 }
          },
          properties = {
            ["easeType"] = "EASE_OUT",
            ["speed"] = "1",
            ["timerMode"] = "LOOP"
          }
        },
        {
          name = "",
          type = "brick3",
          shape = "rectangle",
          x = 832,
          y = 448,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick3",
          shape = "rectangle",
          x = 832,
          y = 128,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick3",
          shape = "rectangle",
          x = 832,
          y = 192,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick3",
          shape = "rectangle",
          x = 832,
          y = 256,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick3",
          shape = "rectangle",
          x = 832,
          y = 384,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "brick3",
          shape = "rectangle",
          x = 832,
          y = 320,
          width = 64,
          height = 64,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      name = "clouds_1",
      x = 0,
      y = 0,
      width = 18,
      height = 10,
      visible = false,
      opacity = 1,
      properties = {
        ["parallax_x"] = "0.7",
        ["sheet"] = "tiles_sheet_1"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "clouds_2",
      x = 0,
      y = 0,
      width = 18,
      height = 10,
      visible = false,
      opacity = 1,
      properties = {
        ["parallax_x"] = "0.5",
        ["sheet"] = "tiles_sheet_1"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "mountains",
      x = 0,
      y = 0,
      width = 18,
      height = 10,
      visible = false,
      opacity = 1,
      properties = {
        ["parallax_x"] = "0.2",
        ["sheet"] = "tiles_sheet_1"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "fog",
      x = 0,
      y = 0,
      width = 18,
      height = 10,
      visible = false,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}

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
      imagewidth = 1024,
      imageheight = 1024,
      properties = {},
      tiles = {}
    },
    {
      name = "tiles_background",
      firstgid = 257,
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
        385, 386, 387, 388, 389, 390, 391, 392, 385, 386, 387, 388, 389, 390, 391, 392, 385, 386,
        401, 402, 403, 404, 405, 406, 407, 408, 401, 402, 403, 404, 405, 406, 407, 408, 401, 402,
        417, 418, 419, 420, 421, 422, 423, 424, 417, 418, 419, 420, 421, 422, 423, 424, 417, 418,
        433, 434, 435, 436, 437, 438, 439, 440, 433, 434, 435, 436, 437, 438, 439, 440, 433, 434,
        385, 450, 451, 452, 453, 454, 455, 456, 449, 450, 451, 452, 453, 454, 455, 456, 449, 450,
        465, 466, 467, 468, 469, 470, 471, 472, 465, 466, 467, 468, 469, 470, 471, 472, 465, 466,
        481, 482, 483, 484, 485, 486, 487, 488, 481, 482, 483, 484, 485, 486, 487, 488, 481, 482,
        497, 498, 499, 500, 501, 502, 503, 504, 497, 498, 499, 500, 501, 502, 503, 504, 497, 498,
        385, 386, 387, 388, 389, 390, 391, 392, 385, 386, 387, 388, 389, 390, 391, 392, 385, 386,
        401, 402, 403, 404, 405, 406, 407, 408, 401, 402, 403, 404, 405, 406, 407, 408, 401, 402
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
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
          type = "brick",
          shape = "rectangle",
          x = 256,
          y = 512,
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
        0, 0, 4, 5, 6, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 20, 21, 22, 23, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 6, 7
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 10, 11, 12, 13, 0,
        11, 12, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 26, 27, 28, 29, 0,
        27, 28, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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
        113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 113, 114,
        129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 129, 130,
        145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 145, 146,
        161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 161, 162
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

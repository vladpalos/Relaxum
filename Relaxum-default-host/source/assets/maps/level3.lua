return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 18,
  height = 12,
  tilewidth = 64,
  tileheight = 64,
  properties = {},
  tilesets = {
    {
      name = "tiles_sheet_2",
      firstgid = 1,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../sheets/tiles_sheet_2.png",
      imagewidth = 1024,
      imageheight = 1024,
      properties = {},
      tiles = {}
    },
    {
      name = "tiles_sheet_1",
      firstgid = 257,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../sheets/tiles_sheet_1.png",
      imagewidth = 1024,
      imageheight = 1024,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "back",
      x = 0,
      y = 0,
      width = 18,
      height = 12,
      visible = true,
      opacity = 1,
      properties = {
        ["parallax_x"] = "0.3",
        ["sheet"] = "tiles_sheet_2"
      },
      encoding = "lua",
      data = {
        145, 146, 147, 148, 145, 146, 147, 148, 145, 146, 147, 148, 145, 146, 147, 148, 145, 146,
        161, 162, 163, 164, 161, 162, 163, 164, 161, 162, 163, 164, 161, 162, 163, 164, 161, 162,
        113, 114, 115, 116, 113, 114, 115, 116, 113, 114, 115, 116, 113, 114, 115, 116, 113, 114,
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 1, 2,
        17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 17, 18,
        33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 33, 34,
        49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 49, 50,
        65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 65, 66,
        81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 81, 82,
        97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 97, 98,
        113, 114, 115, 116, 113, 114, 115, 116, 113, 114, 115, 116, 113, 114, 115, 116, 113, 114,
        129, 130, 131, 132, 129, 130, 131, 132, 129, 130, 131, 132, 129, 130, 131, 132, 129, 130
      }
    },
    {
      type = "tilelayer",
      name = "mountains",
      x = 0,
      y = 0,
      width = 18,
      height = 12,
      visible = true,
      opacity = 1,
      properties = {
        ["parallax_x"] = "0.6",
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
        257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 257, 258,
        273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 273, 274,
        289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 289, 290,
        305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 305, 306,
        321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 321, 322,
        337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 337, 338
      }
    },
    {
      type = "tilelayer",
      name = "fog",
      x = 0,
      y = 0,
      width = 18,
      height = 12,
      visible = true,
      opacity = 1,
      properties = {
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
        353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 353, 354,
        369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 369, 370,
        385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 385, 386
      }
    },
    {
      type = "tilelayer",
      name = "solid",
      x = 0,
      y = 0,
      width = 18,
      height = 12,
      visible = true,
      opacity = 1,
      properties = {
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        503, 504, 505, 503, 504, 505, 503, 504, 505, 503, 504, 505, 503, 504, 505, 503, 504, 505
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
      type = "objectgroup",
      name = "hidden",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    }
  }
}

sub init()
  m.box = m.top.findNode("box")
  m.rating = m.top.findNode("rating")

  m.top.observeField("parentalRating", "handleChangeProps")
  m.top.observeField("size", "handleChangeProps")

  setup()
end sub

sub handleChangeProps()
  m.box.width = m.top.size
  m.box.height = m.top.size
  m.rating.width = m.top.size
  m.rating.height = m.top.size
  m.rating.text = m.top.parentalRating
  m.box.color = getColorBox(m.top.parentalRating)
end sub

function getColorBox(rating as string)
  colorsRating = {
    "L": "0x15810f"
    "10": "0x0070ff"
    "12": "0xffbf00"
    "14": "0xff5500"
    "16": "0xcb0c0c"
    "18": "0x1a0202"
  }

  return colorsRating[rating]
end function

sub setup()
  m.box.width = 25
  m.box.height = 25
  m.rating.width = 25
  m.rating.height = 25

  m.rating.text = "L"
  m.box.color = "0x15810f" 
  m.rating.font = "font:SmallestBoldSystemFont"
end sub
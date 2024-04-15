sub init()
  m.title = m.top.findNode("title")
  m.icon = m.top.findNode("icon")

  m.top.ObserveField("content", "setContent")
  setup()
end sub

sub setContent(param as object)
  content = param.getData()

  if content = invalid then return
  m.title.text = content.title
  m.icon.uri = content.hdSmallIconUrl
end sub

sub setup()
  m.title.font = "font:SmallestSystemFont"
  m.title.font.size = 16
  m.title.width = 100
  m.title.height = 60

  m.icon.loadDisplayMode = "scaleToFit"
  m.icon.width = 65
  m.icon.height = 45
end sub
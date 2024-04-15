sub init()
  m.epg = m.top.findNode("epg")

  m.task = createObject("RoSGNode", "EpgTask")
  m.task.observeField("content", "loadEPGContent")
  m.task.control = "run"
end sub

sub loadEPGContent(param as object)
  m.epg.content = param.getData()
end sub
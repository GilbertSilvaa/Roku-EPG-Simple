sub init()
  m.title = m.top.findNode("title")
  m.desc = m.top.findNode("description")
  m.category = m.top.findNode("category")
  m.duration = m.top.findNode("duration")
  m.ratingIcon = m.top.findNode("ratingIcon")
  m.poster = m.top.findNode("poster")
  m.timeGrid = m.top.findNode("timeGrid")
  m.timeGrid.setFocus(true)

  m.top.observeField("content", "loadContent")
  m.timeGrid.observeField("programFocused", "handleProgramChange")
  setup()
end sub

sub loadContent(param as object)
  m.timeGrid.content = param.getData()
end sub

sub handleProgramChange()
  channelPosition = m.timeGrid.programFocusedDetails.focusChannelIndex
  programPosition = m.timeGrid.programFocusedDetails.focusIndex
  channelContent = m.timeGrid.content.getChild(channelPosition)
  programContent = channelContent.getChild(programPosition)
  m.ratingIcon.visible = true
  
  if programContent = invalid then
    m.poster.uri = channelContent.hdSmallIconUrl
    m.title.text = channelContent.title
    m.category.text = "tv-program"
    m.desc.text = ""
    m.ratingIcon.parentalRating = "L"
    return
  end if

  m.poster.uri = programContent.poster
  m.title.text = programContent.title
  m.category.text = programContent.category
  m.desc.text = programContent.description
  m.ratingIcon.parentalRating = programContent.parentalRating

  timeZone = 10800 'time zone 3 hours -> 10800 seconds
  timeStart = programContent.playStart - timeZone
  timeDuration = programContent.playDuration
  dtProgramStart = createObject("RoDateTime")
  dtProgramEnd = createObject("RoDateTime")
  dtProgramStart.fromSeconds(timeStart)
  dtProgramEnd.fromSeconds(timeStart  + timeDuration)

  timeProgramStartStr = formateHoursStr({
    hours: dtProgramStart.getHours()
    minutes: dtProgramStart.getMinutes()
  })
  timeProgramEndStr = formateHoursStr({
    hours: dtProgramEnd.getHours()
    minutes: dtProgramEnd.getMinutes()
  })

  m.duration.text = timeProgramStartStr + " - " + timeProgramEndStr
end sub

sub setup()
  m.title.font = "font:LargeBoldSystemFont"
  m.desc.font.size = 20
  m.category.font.size = 18
  m.duration.font.size = 18
  m.poster.width = 550
  m.poster.height = 320

  dt = createObject("RoDateTime")
  dtSecs = dt.asSeconds()
  now = dtSecs - (dtSecs mod 1800)

  m.timeGrid.contentStartTime = now
  m.timeGrid.programTitleFont.size = 20
  m.timeGrid.channelInfoComponentName = "ChannelItem"
end sub
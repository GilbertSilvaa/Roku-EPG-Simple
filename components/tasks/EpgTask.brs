sub init()
  m.top.functionName = "loadContent"
end sub

sub loadContent()
  responseJson = httpGet("https://661d23cf337c2309fe33bc2e--dulcet-hotteok-cfb318.netlify.app/epg.json")
  response = parseJson(responseJson)
  content = createObject("RoSGNode", "ContentNode")

  for each channel in response.channels
    channelContent = channelContentNode(channel)

    dt = createObject("RoDateTime")
    dtSecs = dt.asSeconds()
    playStart = dtSecs - (dtSecs mod 1800)
    programs = []

    if not type(channel.schedule) = "String" then
      programs = channel.schedule.programs
    end if

    for each program in programs
      programContent = programContentNode(program, playStart)
      channelContent.appendChild(programContent)
      playStart += program.duration
    end for

    content.appendChild(channelContent)
  end for

  m.top.content = content
end sub

function channelContentNode(channel as object)
  channelContent = createObject("RoSGNode", "ContentNode")

  channelContent.setFields({
    id: channel.id
    title: channel.title
    hdSmallIconUrl: channel.poster
  })

  return channelContent
end function

function programContentNode(program as object, playStart)
  programContent = createObject("RoSGNode", "ContentNode")

  programContent.setFields({
    id: program.id
    title: program.title
    hdSmallIconUrl: ""
    playStart: playStart
    playDuration: program.duration
  })
  
  programContent.addFields({
    poster: program.poster
    description: program.description
    category: program.category
    parentalRating: program.classification
  })

  return programContent
end function
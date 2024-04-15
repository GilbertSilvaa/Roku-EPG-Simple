sub main()
  screen = createObject("RoSGScreen")
  m.port = createObject("roMessagePort")
  screen.setMessagePort(m.port)

  scene = screen.createScene("MainScene")
  screen.show()

  while(true)
    msg = wait(0, m.port)
    msgType = type(msg)
    if msgType = "RoSGScreenEvent" then
      if msg.isScreenClosed() then return
    end if
  end while
end sub
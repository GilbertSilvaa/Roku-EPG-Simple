function formateHoursStr(time as object) as string
  hoursStr = time.hours.toStr()
  minutesStr = time.minutes.toStr()

  if time.hours < 10 then hoursStr = "0" + hoursStr
  if time.minutes < 10 then minutesStr = "0" + minutesStr  

  return hoursStr + ":" + minutesStr
end function
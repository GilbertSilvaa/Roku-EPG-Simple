function httpGet(url as string) as string
  request = createObject("RoUrlTransfer")

  if left(url, 5) = "https" then
    request.setCertificatesFile("common:/certs/ca-bundle.crt")
    request.initClientCertificates()
  end if 

  request.setURL(url)
  return request.getToString()
end function
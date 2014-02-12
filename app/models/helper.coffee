bmf.helper = {
  
  httpGet: (the_url) ->
    xmlHttp = null
    xmlHttp = new XMLHttpRequest()
    xmlHttp.open("GET", the_url, false )
    xmlHttp.send(null)
    xmlHttp.responseText

  httpGetJson: (the_url) ->
    JSON.parse(bmf.helper.httpGet(the_url))
}



$.ajaxSetup dataType: "xml"

window.username = null
window.password = null

remoteLists = {}
remoteBoxes = {}

$("form").live "submit", (event) ->
  event.preventDefault()
  form = event.target
  action = $(form).attr("action")
  if action == "/sign_in"
    window.username = $("input[name='username']", form).val()
    window.password = $("input[name='password']", form).val()
  $.ajax action,
    type: form.method,
    data: $(form).serialize(),
    username: window.username,
    password: window.password,
    contentType: "application/x-www-form-urlencoded",
    success: (data) ->
      content = $("#content", data)
      if list = remoteLists[action]
        list.add(content)

loadRemotes = (selector, klass) ->
  remotes = {}
  _.each $(selector), (elem) ->
    href = $(elem).attr("href")
    remote = new klass("#" + elem.id, href)
    remotes[href] = remote
    remote.load()
  remotes

$ ->
  remoteLists = loadRemotes("ul[id][href]", RemoteList)
  remoteBoxes = loadRemotes("li[id][href]", RemoteBox)

class window.RemoteBox
  constructor: (selector, @href) ->
    @el = $(selector)

  load: =>
    $.ajax @href,
      type: "GET",
      username: window.username,
      password: window.password,
      success: (data) =>
        @replace($("#content", data))

  replace: (replacement) =>
    @el.html(replacement.html())

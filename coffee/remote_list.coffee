class window.RemoteList
  constructor: (@selector, @href) ->

  load: =>
    $.get @href, (data) =>
      messages = $(@selector, data)
      $(@selector).replaceWith(messages)

  add: (message) =>
    $("<li>").html(message.html()).prependTo(@selector)

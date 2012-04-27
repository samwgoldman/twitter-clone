$.ajaxSetup dataType: "xml"

$ ->
  messages = new RemoteList("#messages", "/messages")
  messages.load()

  $("form").submit (event) ->
    event.preventDefault()
    form = event.target
    $.ajax form.action,
      type: form.method,
      data: $(form).serialize(),
      contentType: "application/x-www-form-urlencoded",
      success: (data) ->
        message = $("#message", data)
        messages.add(message)

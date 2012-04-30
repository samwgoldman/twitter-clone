class window.RemoteList extends window.RemoteBox
  add: (item) =>
    @el.prepend($("<li>").html(item.html()))

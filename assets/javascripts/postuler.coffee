jQuery ->
  url = document.location.toString()
  if url.match('#')
    $('.nav-tabs a[href=#' + url.split('#')[1] + ']').tab('show')

  $('.nav-tabs a').on 'shown.bs.tab', (e) ->
    history.pushState(null, document.title, e.target.hash)
    display_wufoo($(e.target).data('wufoo-id'))

  display_wufoo $('.nav-tabs .active a').data('wufoo-id')

display_wufoo = (id) ->
  return unless id
  s = document.createElement("script")
  options =
    userName: "lewagon"
    formHash: id
    autoResize: true
    height: "1121"
    async: true
    host: "wufoo.com"
    header: "show"
    ssl: true

  s.src = "//www.wufoo.com/scripts/embed/form.js"
  s.onload = s.onreadystatechange = ->
    wufoo_form = new WufooForm()
    wufoo_form.initialize options
    wufoo_form.display()
    document.body.scrollTop = 0

  scr = document.getElementsByTagName("script")[0]
  par = scr.parentNode
  par.insertBefore s, scr

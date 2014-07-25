(function() {
  var display_wufoo;

  jQuery(function() {
    var url;
    url = document.location.toString();
    if (url.match('#')) {
      $('.nav-tabs a[href=#' + url.split('#')[1] + ']').tab('show');
    }
    $('.nav-tabs a').on('shown.bs.tab', function(e) {
      history.pushState(null, document.title, e.target.hash);
      return display_wufoo($(e.target).data('wufoo-id'));
    });
    return display_wufoo($('.nav-tabs .active a').data('wufoo-id'));
  });

  display_wufoo = function(id) {
    var options, par, s, scr;
    if (!id) {
      return;
    }
    s = document.createElement("script");
    options = {
      userName: "lewagon",
      formHash: id,
      autoResize: true,
      height: "1121",
      async: true,
      host: "wufoo.com",
      header: "show",
      ssl: true
    };
    s.src = "//www.wufoo.com/scripts/embed/form.js";
    s.onload = s.onreadystatechange = function() {
      var wufoo_form;
      wufoo_form = new WufooForm();
      wufoo_form.initialize(options);
      wufoo_form.display();
      return document.body.scrollTop = 0;
    };
    scr = document.getElementsByTagName("script")[0];
    par = scr.parentNode;
    return par.insertBefore(s, scr);
  };

}).call(this);

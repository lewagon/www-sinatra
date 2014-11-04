//= require jquery
//= require bootstrap
//= require postuler
//= require ga
//= require infinite-scroll
//= require "isotope.pkgd.min.js"

$(function() {
  $("[data-toggle=tooltip]").tooltip();
  $('#newsletter-form').submit(function(e) {
    e.preventDefault();
    $.post($(e.target).attr('action'), $(e.target).serialize(), function(data) {
      $('#newsletter-form').hide();
      $('#newsletter-form-thank-you').show();
    });
  });

  $(".all-posts").infinitescroll({
    navSelector: "nav.pagination",
    nextSelector: "nav.pagination a[rel=next]",
    itemSelector: ".js-post"
  }, function(newElements) {
    $(".all-posts").isotope( 'appended', $( newElements ) );
  });

  $(".all-posts").isotope({
    // options for masonry layout mode
    itemSelector : '.js-post',
    masonry: {
      columnWidth: ".col-lg-4"
    }
  });

})


//= require jquery
//= require bootstrap
//= require "postuler"
//= require "ga"

$(function() {
  $("[data-toggle=tooltip]").tooltip();
  $('#newsletter-form').submit(function(e) {
    e.preventDefault();
    $.post($(e.target).attr('action'), $(e.target).serialize(), function(data) {
      $('#newsletter-form').hide();
      $('#newsletter-form-thank-you').show();
    });
  });
})
$(function(){
  $("#main-nl").on("click", function(){
    ga('send', 'event', 'newsletter', 'click', 'main-newsletter');
  });
  $("#paris-nl").on("click", function(){
    ga('send', 'event', 'newsletter', 'click', 'paris-newsletter');
  });
  $("#brussels-nl").on("click", function(){
    ga('send', 'event', 'newsletter', 'click', 'brussels-newsletter');
  });
  $(".blog-aside #main-nl").on("click", function(){
    ga('send', 'event', 'newsletter', 'click', 'blog-newsletter');
  });
});
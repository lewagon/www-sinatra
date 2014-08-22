$(function(){
  $("#Newsletter").on("click", function(){
    ga('send', 'event', 'newsletter', 'click', 'main-newsletter');
  });
  $("#ParisNewsletter").on("click", function(){
    ga('send', 'event', 'newsletter', 'click', 'paris-newsletter');
  });
  $("#BrusselsNewsletter").on("click", function(){
    ga('send', 'event', 'newsletter', 'click', 'brussels-newsletter');
  });
  $("#BlogNewsletter").on("click", function(){
    ga('send', 'event', 'newsletter', 'click', 'blog-newsletter');
  });
});
---
layout: post
title: "Le setup des Meta Tags dans Rails"
author: cedric
labels:
  - tuto
pushed: true
thumbnail: .jpg
description: Indispensables pour votre SEO ainsi que pour obtenir un aperçu qualitatif de vos contenus sur les réseaux sociaux, nous vous proposons ce tuto pour suivre pas à pas le setup des Meta Tags dans une application Rails.
---

Indispensables pour votre SEO ainsi que pour obtenir un aperçu qualitatif de vos contenus sur les réseaux sociaux, nous vous proposons ce tuto pour suivre pas à pas le setup des metatada dans une application Rails.


## Meta Tags, mais de quoi parle t-on ?

Les Meta Tags sont présentes dans le `<head>` de vos pages et peuvent être consultables sur n'importe quel site web.

![Screnshot des Meta Tags du Wagon On-Demand](blog_image_path tuto-metatags-rails.jpg)

Quelques années auparavant, les marketeurs et autres professionnels du référencement les ont surtout utilisé afin d'augmenter (tronquer ?) le pagerank de leur site sur les moteurs de recherche.

Au fur et à mesure des évolutions de ces derniers, elles ont d'avantage pris un rôle cosmétique en fournissant les informations affichés dans l'aperçu de vos contenus sur les réseaux sociaux. Les titres, descriptions de pages et images associées sont autant d'éléments à choyer et à considérer avec attention afin de suciter l'intérêt de vos futures visiteurs / clients via vos posts Facebook, Twitter Cards et Pinterest Rich Pins.

**Exemple :**

<div class="embed-fb">
  <div id="fb-root"></div><script>(function(d, s, id) {  var js, fjs = d.getElementsByTagName(s)[0];  if (d.getElementById(id)) return;  js = d.createElement(s); js.id = id;  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.3";  fjs.parentNode.insertBefore(js, fjs);}(document, 'script', 'facebook-jssdk'));</script><div class="fb-post" data-href="https://www.facebook.com/lewagonformation/posts/349986731866598" data-width="500"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/lewagonformation/posts/349986731866598"><p>[VERY BIG NEWS] Le Wagon en ligne c&#039;est parti! Avec le Wagon OnDemand on d&#xe9;barque sur vos ordis pour vous apprendre &#xe0; coder like a boss!</p>Posted by <a href="https://www.facebook.com/lewagonformation">Lewagon</a> on <a href="https://www.facebook.com/lewagonformation/posts/349986731866598">Tuesday, April 21, 2015</a></blockquote></div></div>
</div>

## Le setup dans Rails

1 Créer des meta tags pour chacune des pages de votre site
2 Le markup HTML
3 Penser aux Meta Tags par défault !
4 Débugger! Débugger ! Débugger !


## Le markup HTML

  ```
  <title><%= title %></title>
  <meta name="description" content="<%= meta_description %>">

  <!-- Facebook Open Graph data -->
  <meta property="og:title" content="<%= title %>" />
  <meta property="og:type" content="event" />
  <meta property="og:url" content="<%= request.original_url %>" />
  <meta property="og:image" content="<%= image_url meta_image %>" />
  <meta property="og:description" content="<%= meta_description %>" />
  <meta property="og:site_name" content="<%= title %>" />

  <!-- Twitter Card data -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:site" content=“@votrecomtetwitter">
  <meta name="twitter:title" content="<%= title %>">
  <meta name="twitter:description" content="<%= meta_description %>">
  <meta name="twitter:creator" content=“@votrecomptetwitter">
  <meta name="twitter:image:src" content="<%= image_url meta_image %>">

  <!-- Schema.org markup for Google+ -->
  <meta itemprop="name" content="<%= title %>">
  <meta itemprop="description" content="<%= meta_description %>">
  <meta itemprop="image" content="<%= image_url meta_image %>">
  ```

## L'appel des données sous Rails

## Pensez au Meta Tags par défault !

## Débuggez ! Débuggez ! Débuggez !

**Pour vos meta FB & Twitter et le reste du monde de l’univers des réseaux sociaux :**

Définissez dans `application-helper.rb` les méthodes suivantes afin de pouvoir créer des métadonnées spécifiques à vos vues/contenus (articles de blog par exemple)

```
module ApplicationHelper

  def title(title = nil)
    if title.present?
      content_for :title, title
    else
      content_for?(:title) ? content_for(:title) : APP_CONFIG['title']
    end
  end

  def meta_description(desc = nil)
    if desc.present?
      content_for :meta_description, desc
    else
      content_for?(:meta_description) ? content_for(:meta_description) : APP_CONFIG['meta_description']
    end
  end

  def meta_image(desc = nil)
    if desc.present?
      content_for :meta_image, desc
    else
      content_for?(:meta_image) ? content_for(:meta_image) : APP_CONFIG['meta_image']
    end
  end
end
```

Placez ensuite les metas suivantes dans votre `head` (view > layout > application.html.erb)

```
<title><%= title %></title>
 <meta name="description" content="<%= meta_description %>">

  <!-- Schema.org markup for Google+ -->
  <meta itemprop="name" content="<%= title %>">
  <meta itemprop="description" content="<%= meta_description %>">
  <meta itemprop="image" content="<%= image_url meta_image %>">

  <!-- Twitter Card data -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:site" content=“@votrecomtetwitter">
  <meta name="twitter:title" content="<%= title %>">
  <meta name="twitter:description" content="<%= meta_description %>">
  <meta name="twitter:creator" content=“@votrecomptetwitter">
  <meta name="twitter:image:src" content="<%= image_url meta_image %>">

  <!-- Open Graph data -->
  <meta property="og:title" content="<%= title %>" />
  <meta property="og:type" content="event" />
  <meta property="og:url" content="<%= request.original_url %>" />
  <meta property="og:image" content="<%= image_url meta_image %>" />
  <meta property="og:description" content="<%= meta_description %>" />
  <meta property="og:site_name" content="<%= title %>" />
```

Et pour loader les metas par default n’oubliez pas de créer un `meta.yml` dans config contenant :

```
default_title: “Titre générique"
meta_description: “Description générique."
meta_image: “image.jpg”
```

et de l’appeler dans `environnement.rb`

```
# Initialize default meta tags.
APP_CONFIG = YAML.load_file("#{Rails.root}/config/meta.yml”)
```

Puis définissez le contenu de vos metas dans vos vues :

```
<% title “Titre de votre site" %>
<% meta_description “Description de votre site" %>
<% meta_image “nomimage.jpg" %>
```

Enfin il est nécessaire de dire à Rails de retourner l’url absolue des images. Calez ce snippet dans votre `application-controller.rb`:

```
def default_url_options
    if Rails.env.production?
      { host: ‘votresite.herokuapp.com' }
    else
      {}
    end
  end
```

Rendez-vous ensuite sur...

- https://developers.facebook.com/tools/debug/
- https://cards-dev.twitter.com/validator
-

… pour débuger tout ça !
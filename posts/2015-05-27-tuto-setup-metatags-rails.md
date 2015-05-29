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

L'idée de ce tutorial est de vous montrer comment obtenir ce résultat sur chacune des vues de votre site. Nous allons donc commencer par configurer des Meta Tags par défault avant de définir des helpers qui vous permettrons de les customiser sur les vues de votre choix. Enfin nous jetterons un oeil sur le markup HTML nécessaire et les outils de débuggage à votre disposition.

### Créez des Meta Tags par défault

Commencez par créer un fichier `meta.yml` dans `config` en prenant soin de rédiger un titre et une description accrocheur puis d'appeler une image de votre produit/service tout aussi flateur pour la rétine.

```
default_title: "Titre générique"
meta_description: "Description générique."
meta_image: "image.jpg"
```

Et appelez ensuite ce `.yml` dans `environnement.rb` :

```
# Initialize default meta tags.
APP_CONFIG = YAML.load_file("#{Rails.root}/config/meta.yml")
```

### Helpers : *meta_title*, *meta_description* & *meta_image*

Dans `application-helper.rb` définissez les méthodes suivantes afin de pouvoir créer des Meta Tags spécifiques à vos vues/contenus :

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

### Important : la gestion des URLs de vos images

Par défault, Rails retourne l'url relative de vos assets. Il est donc primordial de lui dire de retourner les urls absolues afin que celles-ci puissent être récupéreés par Facebook et Twitter. Pour ce faire, placez le snippet suivant dans votre `application-controller.rb`:

```
def default_url_options
  if Rails.env.production?
    { host: ‘votresite.herokuapp.com' }
  else
    {}
  end
end
```

### Le markup HTML

Copiez/collez ensuite les metas suivantes dans le `head` de votre application :

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

  <!-- Google+ Schema.org markup -->
  <meta itemprop="name" content="<%= title %>">
  <meta itemprop="description" content="<%= meta_description %>">
  <meta itemprop="image" content="<%= image_url meta_image %>">
  ```

Puis définissez le contenu de vos Meta Tags pour chacunes des vues pour lesquelles vous souhaitez générer un aperçu unique :

```
<% title "Titre de votre site" %>
<% meta_description "Description de votre site" %>
<% meta_image "nomimage.jpg" %>
```

### Enfin... Débugger! Débugger ! Débugger !


Rendez-vous ensuite sur...

- [Facebook Debug Tool](https://developers.facebook.com/tools/debug/)
- [Twitter Card Validator](https://cards-dev.twitter.com/validator)
- [Pinterest Rich Pins Validator](https://developers.pinterest.com/rich_pins/validator/)

… pour débuger tout ça !

La meta `og:type` risque bien souvant de vous poser problème, n'hésitez pas à consulter [la documentation Facebook](https://developers.facebook.com/docs/reference/opengraph) pour vous éclairer sur la chose !


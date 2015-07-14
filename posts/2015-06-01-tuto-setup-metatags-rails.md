---
layout: post
title: "Le setup des Meta Tags dans Rails"
author: cedric
labels:
  - tuto
pushed: true
thumbnail: thumbnail-tuto-meta-tags.jpg
description: Éléments indispensables pour obtenir un aperçu qualitatif de vos contenus sur les réseaux sociaux, nous vous proposons ce tutoriel pour suivre pas à pas le setup des Meta Tags dans une application Rails.
---

Éléments indispensables pour obtenir un aperçu qualitatif de vos contenus sur les réseaux sociaux, nous vous proposons ce tutoriel pour suivre pas à pas le setup des Meta Tags dans une application Rails.

![Le setup des Meta Tags dans Rails](blog_image_path thumbnail-tuto-meta-tags.jpg)

## Meta Tags, mais de quoi parle t-on ?

Les Meta Tags sont présentes dans le `<head>` de vos pages et peuvent être consultables sur n'importe quel site web.

![Screnshot des Meta Tags du Wagon On-Demand](blog_image_path tuto-metatags-rails.jpg)

Les Meta Tags fournissent les informations affichées dans l'aperçu de vos contenus sur les réseaux sociaux. Les titres, descriptions et images associées sont autant d'éléments à choyer et à considérer avec attention afin de susciter l'intérêt de vos futurs visiteurs / clients via vos posts Facebook, Tweet et Pinterest Rich Pins.

**Exemple :**

<div class="embed-fb">
  <div id="fb-root"></div><script>(function(d, s, id) {  var js, fjs = d.getElementsByTagName(s)[0];  if (d.getElementById(id)) return;  js = d.createElement(s); js.id = id;  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.3";  fjs.parentNode.insertBefore(js, fjs);}(document, 'script', 'facebook-jssdk'));</script><div class="fb-post" data-href="https://www.facebook.com/lewagonformation/posts/349986731866598" data-width="500"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/lewagonformation/posts/349986731866598"><p>[VERY BIG NEWS] Le Wagon en ligne c&#039;est parti! Avec le Wagon OnDemand on d&#xe9;barque sur vos ordis pour vous apprendre &#xe0; coder like a boss!</p>Posted by <a href="https://www.facebook.com/lewagonformation">Lewagon</a> on <a href="https://www.facebook.com/lewagonformation/posts/349986731866598">Tuesday, April 21, 2015</a></blockquote></div></div>
</div>


## Le setup dans Rails

L'idée de ce tutoriel est de vous montrer comment obtenir ce résultat sur chacune des vues de votre site. Nous allons donc commencer par configurer des Meta Tags par défaut avant de définir des helpers qui vous permettront de les customiser sur les vues de votre choix. Enfin nous jetterons un oeil sur le markup HTML nécessaire et les outils de débogage à votre disposition.

### Créez des Meta Tags par défaut

Commencez par créer un nouvel fichier `meta.yml` dans `config`, avec le contenu suivant :

**Important :** Prenez soin ensuite de rédiger un titre accrocheur, une description percutante et de choisir une image mettant parfaitement en valeur votre produit ou service.

```
# config/meta.yml
default_title: "Titre générique"
meta_description: "Description générique."
meta_image: "image.jpg" # Une image dans votre dossier app/assets/images/
twitter_account: "@nomdevotrecompte" #indispensable pour les Twitter Cards

```

Et chargez ensuite ce `.yml` dans le fichier `config/environnement.rb` :

```
# config/environment.rb

# [...]

# Initialize default meta tags.
DEFAULT_META = YAML.load_file(Rails.root.join('config/meta.yml'))
```


### Helpers : *meta_title*, *meta_description* & *meta_image*

Dans `application_helper.rb` définissez les méthodes suivantes afin de pouvoir créer des Meta Tags spécifiques à vos vues/contenus :

```
module ApplicationHelper
  def title
    content_for?(:title) ? content_for(:title) : DEFAULT_META['default_title']
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) : DEFAULT_META['meta_description']
  end

  def meta_image
    content_for?(:meta_image) ? content_for(:meta_image) : DEFAULT_META['meta_image']
  end
end
```


### Important : la gestion des URLs de vos images

Par défaut, Rails retourne le chemin **relatif** de vos assets (helpers suffixés en `_path`). Il est donc primordial de lui dire de retourner les urls absolues afin que celles-ci puissent être récupérées par Facebook et Twitter. Pour ce faire, placez le snippet ci-dessous dans votre `application_controller.rb`.

```
def default_url_options
  if Rails.env.production?
    { host: 'votresite.herokuapp.com' }
  else
    { host: ENV['HOST'] || 'localhost:3000' }
  end
end
```

**Important :**  Par la suite, veillez à bien utiliser les helpers de routes en _url. Exemple :

```erb
<%= image_url meta_image %>
```


### Le markup HTML

Rendez-vous ensuite dans `app/views/layouts/application.html.erb` et copiez/collez ensuite les Meta Tags suivants dans le `head` de votre application :

```erb
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
<meta name="twitter:site" content=“<%= DEFAULT_META[:twitter_account] %>">
<meta name="twitter:title" content="<%= title %>">
<meta name="twitter:description" content="<%= meta_description %>">
<meta name="twitter:creator" content=“<%= DEFAULT_META[:twitter_account] %>">
<meta name="twitter:image:src" content="<%= image_url meta_image %>">

<!-- Google+ Schema.org markup -->
<meta itemprop="name" content="<%= title %>">
<meta itemprop="description" content="<%= meta_description %>">
<meta itemprop="image" content="<%= image_url meta_image %>">
```

Puis définissez le contenu de vos Meta Tags pour chacune des vues pour lesquelles vous souhaitez générer un aperçu unique. Par exemple, imaginons que nous avons une page show du modèle Product, vous pouvez mettre en haut de la vue app/views/products/show.html.erb le code suivant :

```erb
<!-- app/views/products/show.html.erb -->
<% title "#{@product.name} à seulement #{@product.price} €" %>
<% meta_description @product.description %>
<% meta_image @product.url %>
```

Vous remarquez l'aspect dynamique des Meta Tags puisque nous prenons directement des propriétés du modèle (stockées dans la base de données) qui varient d'une page show à l'autre !


## Enfin... Débuggez! Débuggez ! Débuggez !

Afin de tester ce setup sans déployer votre application, [installez `ngrok` pour débugger en local (mac)](https://ngrok.com/) avec :

```
$ brew install ngrok
```

Ngrok créé une URL publique sécurisée sur un serveur basé sur votre ordinateur :

```bash
$ ngrok 3000
```

Ouvrez un nouvel onglet sur votre terminal puis lancez ensuite un serveur en exécutant la commande suivante (en remplaçant le numéro sous-domaine par celui que ngrok vous a donné) :

```bash
$ HOST=23872376.ngrok.com rails s
```

Ouvrez votre navigateur, rendez-vous sur `https://23872376.ngrok.com` puis copiez les URLs des vues que vous souhaitez tester avant de vous rendez sur...

- [Facebook Debug Tool](https://developers.facebook.com/tools/debug/)
- [Twitter Card Validator](https://cards-dev.twitter.com/validator)
- [Pinterest Rich Pins Validator](https://developers.pinterest.com/rich_pins/validator/)

… pour valider tout ça !

**Important :** Le Meta Tag `og:type` risque bien souvent de vous poser problème, n'hésitez pas à consulter [la documentation Facebook](https://developers.facebook.com/docs/reference/opengraph) pour vous éclairer sur la chose !

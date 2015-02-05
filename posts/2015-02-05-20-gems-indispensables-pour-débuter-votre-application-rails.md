---
layout: post
title: "20 gems indispensables pour débuter votre application rails"
author: cedric
labels:
  - meetup
  - tuto
  - video
pushed: true
thumbnail: 20-gems-starts-rubyonrails-project.jpg
description: De votre environnement de développement à la mise en production, voici une sélection non exhausitve d'un vingtaine de gems aux fonctionnalités aussi diverses que variées mais toutefois indispensables au lancement de votre projet. L'objectif ? Gagner un temps précieux dans votre temps de développement en vous évitant de coder à la main des features déjà existantes.
---

De votre environnement de développement à la mise en production, voici une sélection non exhausitve d'un vingtaine de gems aux fonctionnalités aussi diverses que variées mais toutefois indispensables au lancement de votre projet. L'objectif ? Gagner un temps précieux dans votre temps de développement en vous évitant de coder à la main des features déjà existantes.

**Important :** Nous vous invitons ensuite à consulter la documentations de chacune des gems présentées afin de savoir comment les utiliser au sein de votre projet.

![20 gems indispensables pour débuter votre application rails](blog_image_path 20-gems-starts-rubyonrails-project.jpg)


###Development:

Les gems suivantes sont à inclure au sein de votre `Gemfile` dans le groupe `:development` afin de n'en bénéficier qu'en local.

```
group :development do
  gem "better_errors"
  gem "binding-of-caller"
  gem "quiet_assets"
  gem "pry-byebug"
  gem "Faker"
  gem "letter_opener"
end
```

####*Better Errors & Binding of Caller* - [<i class="fa fa-github fa-1x"></i>](https://github.com/charliesome/better_errors)

Ces deux gems travaillent de concert de remplacer la page d'erreur par défaut de Rails afin de vous indiquer où se trouve l'erreur, vous proposer un REPL (une console), inspecter vos variables d'instance et de retracer la stack complète de votre application.


####Pry Byebug - [<i class="fa fa-github fa-1x"></i>](https://github.com/deivid-rodriguez/pry-byebug)

Pry Byebug offre une alternative à IRB et qui permet notement de stoper l'exécution du code de votre application et propose une alternative à IRB en vous offrant la possibilité de tester/débugger votre application à la volée.

####*Puma* - [<i class="fa fa-github fa-1x"></i>](https://github.com/puma/puma)

Puma est un serveur HTTP plus rapide que Webrick (proposé de base sur vos applications Rails). Cette gem permet d'augmenter les performances quotidiennes de votre site et de mieux gérer une évenutelle charge de traffic en traitant plusieurs requêtes en simultané.


####*Quiet Assets* - [<i class="fa fa-github fa-1x"></i>](https://github.com/evrone/quiet_assets)

Quiet Assets vous permet de soulager le log votre console de développement en supprimant les requêtes `http` liées à l'asset pipeline de Rails. Dites au revoir aux moultes `"GET /assets/blog/thumbail-api-webhook-tutorial-be5d3373ac225d0d5d0f0060aa7b3eeb.jpg HTTP/1.1" 304 - 0.0154` et soulagez vos rétines.


####Faker - [<i class="fa fa-github fa-1x"></i>](https://github.com/stympy/faker)

Un indispensable pour peupler votre base de donnée (nom, email, addresses...) lors du développement de votre application sans avoir à tout créer à la main !

####Letter Opener - [<i class="fa fa-github fa-1x"></i>](https://github.com/ryanb/letter_opener)

Letter Opener vous permet de prévisualiser vos emails directement dans votre navigateur sans avoir à inclure une système d'envoie d'emails au sein de votre environnement de développement.


###Déploiement

Les gems suivantes sont à inclure au sein de votre `Gemfile` dans le groupe `:production` afin de n'en bénéficier que lorsque votre application est pushée sur Heroku ou tout autre service.

```
group :production do
  gem "rails_12factor"
  gem "figaro"
end
```

####*Rails 12factor* - [<i class="fa fa-github fa-1x"></i>](https://github.com/heroku/rails_12factor)

Rails 12factor réécrit quelques paramêtre instrasèques à Rails afin de faciliter la scalibilité et la mise à jour réguilière de votre application selon les conventions de [12factor](http://12factor.net). Cette gem s'occupe principalement de donner un accès aux logs et également au dossier `app/assets` d'être servie en production afin de donner un accès à vos fichiers css, js et images.


####*Figaro* - [<i class="fa fa-github fa-1x"></i>](https://github.com/laserlemon/figaro)

Figaro vous permet de renforcer la sécurité de votre application en masquant les tokens, mots de passe et autre credentials d'APIs afin d'empêcher Git de les stocker (et ainsi à tout à chacun d'y avoir accès). Il vous est tout de même possible d'y avoir accès via la variable d'environnement `ENV`.


###Quelques fonctionnalités utiles

####Bootstrap Sass - [<i class="fa fa-github fa-1x"></i>](https://github.com/twbs/bootstrap-sass#a-ruby-on-rails)

De manière très concrète, après avoir installé cette gem et importé les styles Bootstrap dans `app/assets/stylesheets/application.scss` via  `@import "bootstrap-sprockets";` et `@import "bootstrap";` vous aurez ensuite accès à l'ensemble du [framework CSS Bootstrap](http://getbootstrap.com/) via votre markup `html`.


####*Simple Form* - [<i class="fa fa-github fa-1x"></i>](https://github.com/plataformatec/simple_form)

Simple Form vous simplifie la création de vos formulaires grace à un synthaxe très légère et vous donne la possibilité d'invoquer et de customiser les éléments label, hints, errors et input selon votre bon vouloir.

```
<%= simple_form_for @user do |f| %>
  <%= f.input :username, label: 'Your username please' %>
  <%= f.input :password, hint: 'No special characters.' %>
  <%= f.input :email, placeholder: 'user@domain.com' %>
  <%= f.input :remember_me, inline_label: 'Yes, remember me' %>
  <%= f.button :submit %>
<% end %>
```

A noter que cette gem est très facilement intégrable avec Bootstrap et Foundation via ses options d'installation.


####Devise & Omniauth - [<i class="fa fa-github fa-1x"></i>](https://github.com/plataformatec/devise)

Devise vous offre une solution d'autentification complète (Modèle, Vue et Controller) fiable et sécurisé. Outre le fait d'offrir à plusieurs utilisateur la possibilité d'être connectés en même temps, cette gem peut également être agrémenté du module [Omniauth](https://github.com/intridea/omniauth) afin de permettre à vos utilisateurs de se conencter à votre service via Facebook ou Twitter Connect.


####Pundit - [<i class="fa fa-github fa-1x"></i>](https://github.com/elabs/pundit)

Pundit permet de gérer simplement et de manière centralisée les autorisations des utilisteurs de votre applications dans `app/policies`. A vous de dupliquer à l'intérieur de ce fichier tous vos modèles de class accompagnées du suffice `Policy`. Définisez ensuite les droits de vos `current_user` sur chaque méthode de class afin de les laisser ou faire telle ou telle action.


####Paperclip, Carrierwave & Dragonfly - [<i class="fa fa-github fa-1x"></i>](https://github.com/thoughtbot/paperclip)

Ces trois gems aux fonctionnements quelque peu différents se proposent de gérer l'upload et le traitement de vos images. D'un côté [Paperclip](https://github.com/thoughtbot/paperclip) et [Carrierwave](https://github.com/carrierwaveuploader/carrierwave) génère vont s'occuper de resizer puis de stocker en base de donnée l'original du fichier ainsi que toutes les redimensions nécessaires à votre template de cette même image.

De l'autre, [Dragonfly](https://github.com/markevans/dragonfly). Cette gem stock la version orginale dans un premier temps et la redimensionne à la volée pour chaque action de l'utilisateur. Cela nécessite l'installation d'un cache pour resservir les images afin de limiter au maximum un travail serveur trop important.

####Gibbon - [<i class="fa fa-github fa-1x"></i>](https://github.com/amro/gibbon)

####Google Map for Rails - [<i class="fa fa-github fa-1x"></i>](https://github.com/apneadiving/Google-Maps-for-Rails)

####High Voltage - [<i class="fa fa-github fa-1x"></i>]()

####Kaminari - [<i class="fa fa-github fa-1x"></i>]()

####Cocoon - [<i class="fa fa-github fa-1x"></i>]()

####Active Admin - [<i class="fa fa-github fa-1x"></i>]()

####Sidekiq - [<i class="fa fa-github fa-1x"></i>]()


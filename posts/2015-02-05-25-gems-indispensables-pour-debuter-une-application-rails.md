---
layout: post
title: "25 gems indispensables pour débuter une application rails"
author: cedric
labels:
  - tuto
  - misc
thumbnail: 25-gems-starts-rubyonrails-project.jpg
description: De votre environnement de développement à la mise en production, voici une sélection non exhaustive d'une vingtaine de gems aux fonctionnalités aussi diverses que variées mais indispensables au lancement de votre projet. L'objectif ? Gagner un temps précieux dans votre temps de développement en vous évitant de coder à la main des features déjà existantes.
---

De votre environnement de développement à la mise en production, voici une sélection non exhaustive d'une vingtaine de gems aux fonctionnalités aussi diverses que variées, mais indispensables au lancement de votre projet. L'objectif ? Gagner un temps précieux dans votre temps de développement en vous évitant de coder à la main des features déjà existantes.

**Important :** Nous vous invitons ensuite à consulter la documentation de chacune des gems présentées afin de savoir comment les utiliser au sein de votre projet.

![25 gems indispensables pour débuter votre application rails](blog_image_path 25-gems-starts-rubyonrails-project.jpg)


###Development:

Les gems suivantes sont à inclure au sein de votre `Gemfile` dans le groupe `:development` afin de n'en bénéficier qu'en local.

```
group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "quiet_assets"
  gem "pry-byebug"
  gem "faker"
  gem "letter_opener"
end
```

####*Better Errors & Binding of Caller* - [<i class="fa fa-github fa-1x"></i>](https://github.com/charliesome/better_errors)

Ces deux gems travaillent de concert pour remplacer la page d'erreur par défaut de Rails afin de vous indiquer où se trouve l'erreur, vous proposer un [REPL](http://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) (une console), inspecter `params`, vos variables d'instance et de parcourir facilement la stack d’une erreur.

####*Pry Byebug* - [<i class="fa fa-github fa-1x"></i>](https://github.com/deivid-rodriguez/pry-byebug)

[Pry](https://vimeo.com/87710671) offre une alternative colorée à IRB, et Pry Byebug permet de stopper l'exécution du code, avec des points d’arrêt, pour vous offrir la possibilité de tester/débugger votre application à la volée.

####*Puma* - [<i class="fa fa-github fa-1x"></i>](https://github.com/puma/puma)

Puma est un serveur HTTP plus rapide que Webrick (proposé de base sur vos applications Rails). Cette gem permet d'augmenter les performances quotidiennes de votre site et de mieux gérer une éventuelle charge de trafic en traitant plusieurs requêtes en parallèle.


####*Quiet Assets* - [<i class="fa fa-github fa-1x"></i>](https://github.com/evrone/quiet_assets)

Quiet Assets vous permet de soulager le log de votre console de développement en supprimant les requêtes `HTTP` liées à l'*assets pipeline* de Rails. Dites au revoir aux multiples `"GET /assets/blog/thumbnail-api-webhook-tutorial-be5d3373ac225d0d5d0f0060aa7b3eeb.jpg HTTP/1.1" 304 - 0.0154` et soulagez vos rétines.


####*Faker* - [<i class="fa fa-github fa-1x"></i>](https://github.com/stympy/faker)

Un indispensable pour peupler votre base de fausses données (nom, email, adresses...) lors du développement de votre application sans avoir à tout créer à la main !

#### *Letter Opener*  - [<i class="fa fa-github fa-1x"></i>](https://github.com/ryanb/letter_opener)

Letter Opener vous permet de prévisualiser vos emails directement dans votre navigateur sans avoir à inclure un système d'envoi d'emails au sein de votre environnement de développement.


###Déploiement

Les gems suivantes sont à inclure au sein de votre `Gemfile` dans le groupe `:production` afin de n'en bénéficier que lorsque votre application est pushée sur Heroku ou tout autre service.

```ruby
group :production do
  gem "rails_12factor"
end
```

####*Rails 12factor* - [<i class="fa fa-github fa-1x"></i>](https://github.com/heroku/rails_12factor)

Rails 12factor réécrit quelques paramètres de Rails afin de faciliter la scalabilité et la mise à jour régulière de votre application selon les conventions de [12factor](http://12factor.net). Cette gem s'occupe principalement de donner un accès aux logs et également au dossier `app/assets` d'être servi en production afin de donner un accès à vos fichiers css, js et images.


###Quelques fonctionnalités utiles


####*Bootstrap Sass* - [<i class="fa fa-github fa-1x"></i>](https://github.com/twbs/bootstrap-sass#a-ruby-on-rails)

De manière très concrète, après avoir installé cette gem et importé les styles Bootstrap dans `app/assets/stylesheets/application.scss` via  `@import "bootstrap-sprockets";` et `@import "bootstrap";` vous aurez ensuite accès à l'ensemble du [framework CSS Bootstrap](http://getbootstrap.com/) via votre markup `html`.


####*Simple Form* - [<i class="fa fa-github fa-1x"></i>](https://github.com/plataformatec/simple_form)

Simple Form simplifie la création de vos formulaires grâce à une syntaxe très légère et vous donne la possibilité d'invoquer et de customiser les éléments label, hints, errors et input selon votre bon vouloir.

```erb
<%= simple_form_for @user do |f| %>
  <%= f.input :username, label: 'Your username please' %>
  <%= f.input :password, hint: 'No special characters.' %>
  <%= f.input :email, placeholder: 'user@domain.com' %>
  <%= f.input :remember_me, inline_label: 'Yes, remember me' %>
  <%= f.button :submit %>
<% end %>
```

À noter que cette gem est très facilement intégrable avec Bootstrap et Foundation via ses options d'installation.


####*Devise & Omniauth* - [<i class="fa fa-github fa-1x"></i>](https://github.com/plataformatec/devise)

Devise vous offre une solution d'authentification complète (Modèle, Vue et Controller) fiable et sécurisée. Outre le fait d'offrir à plusieurs utilisateurs la possibilité d'être connectés en même temps, cette gem peut également être agrémentée du module [Omniauth](https://github.com/intridea/omniauth) afin de permettre à vos utilisateurs de se connecter à votre service via Facebook ou Twitter Connect.


####*Pundit* - [<i class="fa fa-github fa-1x"></i>](https://github.com/elabs/pundit)

Pundit permet de gérer simplement et de manière centralisée les autorisations des utilisateurs de votre application dans `app/policies`. À vous de dupliquer à l'intérieur de ce fichier toutes vos classes controller accompagnées du suffixe `Policy`. Définissez ensuite les droits de vos `current_user` sur chaque méthode de classe afin de les laisser ou faire telle ou telle action du controller associé.


####*Paperclip, Carrierwave & Dragonfly* - [<i class="fa fa-github fa-1x"></i>](https://github.com/thoughtbot/paperclip)

Ces trois gems aux fonctionnements légèrement différents se proposent de gérer l'upload et le traitement de vos images. D'un côté [Paperclip](https://github.com/thoughtbot/paperclip) et [Carrierwave](https://github.com/carrierwaveuploader/carrierwave) vont s'occuper de redimensionner puis de stocker l'original du fichier ainsi que toutes les redimensions nécessaires à votre template de cette même image.

De l'autre côté, [Dragonfly](https://github.com/markevans/dragonfly). Cette gem stocke la version originale dans un premier temps et la redimensionne à la volée pour chaque action de l'utilisateur. Cela nécessite l'installation d'un cache pour resservir les images afin de limiter au maximum un travail serveur trop important.

####*Gibbon* - [<i class="fa fa-github fa-1x"></i>](https://github.com/amro/gibbon)

Gibbon est un wrapper dédié à l'API MailChimp afin de vous aider à synchroniser votre base de données pour affiner la gestion de vos listes, créer de nouveaux segments en fonction des actions de vos utilisateurs, ou tout simplement créer un formulaire d'inscription au sein de votre application. L’avantage de la gem sur le widget javascript est la possibilité de désactiver le [*double opt-in*](http://blog.mailchimp.com/double-opt-in-vs-single-opt-in-stats/)


####*Google Maps for Rails* - [<i class="fa fa-github fa-1x"></i>](https://github.com/apneadiving/Google-Maps-for-Rails)

Gmaps4rails vous permet de très rapidement customiser vos Google Maps en y incluant des marqueurs et fenêtres d'informations dynamiques.


####*Kaminari* - [<i class="fa fa-github fa-1x"></i>](https://github.com/amatsuda/kaminari)

Kaminari offre une solution complète et intégralement customisable pour vos paginations. Une fois installée, tous vos modèles peuvent être paginés sans aucune action requise de votre part du côté des modèles et des helpers.


####*High Voltage* - [<i class="fa fa-github fa-1x"></i>](https://github.com/thoughtbot/high_voltage)

High Voltage vous permet de très simplement gérer vos pages statiques. Après l'installation il vous suffit de créer un dossier `pages` dans vos `views` et d'y placer vos pages. Aucune configuration de rooting, pas de helpers à créer, ni de controller. Tout est pris en charge pour vous !

####*Figaro* - [<i class="fa fa-github fa-1x"></i>](https://github.com/laserlemon/figaro)

Figaro vous permet de renforcer la sécurité de votre application en masquant les tokens, mots de passe et autre credentials d'APIs afin d'empêcher Git de les stocker (et ainsi à tout un chacun d'y avoir accès). Il vous est tout de même possible d'y avoir accès via la variable d'environnement `ENV`.


####*Rails-i18n* - [<i class="fa fa-github fa-1x"></i>](https://github.com/svenfuchs/i18n)

Traduisez et localisez votre site rapidement grâce à rails-i18n. Rédigez toutes vos traductions dans des fichiers `yml` placés dans `config > locals` et appelez-les au sein de vos vues en fonction de la langue sélectionnée par vos utilisateurs.


####*Cocoon* - [<i class="fa fa-github fa-1x"></i>]()

Cocoon permet une gestion plus simple des formulaires nestés en permettant de créer, détruire, mettre à jour l'ensemble des modèles impliqués sur une unique vue.


####*Active Admin* - [<i class="fa fa-github fa-1x"></i>](https://github.com/activeadmin/activeadmin)

Tous les administrateurs de votre service ne sont pas forcément des développeurs, et donc ne pourront pas se contenter d’un `heroku run bundle exec rails c`. Active Admin permet de créer une interface d'administration intégralement et facilement customisable avec l'ensemble des fonctionnalités de votre application.


####*Sidekiq* - [<i class="fa fa-github fa-1x"></i>](https://github.com/mperham/sidekiq)

Sidekiq est l’une des gems de gestion de worker, pour exécuter les traitements lourds de votre application dans des processus asynchrones, mis dans une file d’attente. Depuis Rails 4.2, un framework unifié, [ActiveJob](http://edgeguides.rubyonrails.org/active_job_basics.html) est disponible. Sidekiq est compatible avec cette approche. Un exemple d’utilisation de Sidekiq est l’envoi d’un mail à 10 utilisateurs. Si vous exécutez cette action dans un controller, l’utilisateur va attendre longtemps que le traitement soit fait, et avoir une impression de navigation lente. Si vous déchargez ce traitement dans un worker sidekiq, vous pouvez renvoyer une page web à votre utilisateur rapidement en confiant l’exécution de la tâche longue à Sidekiq.


###Liens utiles

- [Rubygems](https://rubygems.org/gems)
- [Railscasts](http://railscasts.com/)

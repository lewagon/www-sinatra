---
layout: post
title: "Publiez votre premier site web en moins de 10 minutes"
author: cedric
labels:
  - tuto
pushed: true
thumbnail: thumbnail-tuto-gh-pages.jpg
description: Vous souhaitez tester une idée ou mettre votre portfolio en ligne ? Alors ce tuto sur Github Pages est fait pour vous. En seulement quelques clics, vous pourrez héberger gratuitement votre premier site statique intégralement customisable et le partager ensuite au gré de vos envies.
---

Vous souhaitez tester une idée ou mettre votre portfolio en ligne ? Alors ce tuto sur Github Pages est fait pour vous. En seulement quelques clics, vous pourrez héberger gratuitement votre premier site statique intégralement customisable et le partager ensuite au gré de vos envies.

### Votre compte Github

Si vous ne connaissez pas encore Github, le service de collaboration entre développeurs, nous vous recommandons de suivre [le tuto vidéo sur Git et Github](http://www.lewagon.org/blog/meetup-git-github) de [@ssaunier](https://twitter.com/ssaunier), CTO du Wagon, et de vous créer un compte gratuitement sur [GitHub](https://github.com/) (obligatoire pour la suite).

![Inscription Github](blog_image_path tuto-gh-pages-1.jpg)

### Le Setup : GitHub Mac/Windows

Téléchargez ensuite [GitHub Mac](https://mac.github.com/) ou [GitHub Windows](https://windows.github.com/) et configurez là en suivant les 3 étapes :

- Connectez l'application à votre compte Github fraîchement créé en précisant votre nouveau login et password.
- Pour la config Git, précisez absolument l'email que vous avez utilisé lors de la création de votre compte GitHub afin de permettre au service de bien associer votre travail à votre compte.
- L'application cherchera des projets existants sur votre machine. Vous pouvez passer cette étape si vous le souhaitez.

### Votre premier projet

Créez un dossier sur votre machine ```github-pages-exemple``` (le nom reste à votre convenance) et glissez-le sur la fenêtre de l'application GitHub.

![Lier votre projet et GitHub](blog_image_path tuto-gh-pages-2.jpg)

Un popup d'avertissement vous informera que ce projet n'est pas encore un *repository* (comprenez *un projet* dans le jargon Github) connu de votre compte et vous demandera si vous souhaitez qu'il soit considéré en tant que tel. Cliquez sur *Créer et Ajouter*.

**Important** Créez une nouvelle branche ```gh-pages``` sur votre projet en cliquant sur l'icône dédiée en haut à gauche.

![Branche gh-pages](blog_image_path tuto-gh-pages-3.jpg)

À l'intérieur de votre dossier local, et grâce à votre éditeur de texte préféré (ex: [Sublime Text](http://www.sublimetext.com/)), créez une page ```index.html``` et placez-y le code de [Boostrap Boilerplate](https://github.com/lewagon/bootstrap-boilerplate). Ce premier markup HTML initialise [le framework CSS Bootstrap](http://getbootstrap.com/css/) ce qui permet de construire très simplement votre landing page. Ajoutez également un peu de texte sous la balise ```<body>```.

Exemple :

```html
<div class="container">
  <div class="row">
    <div class="col-md-4 col-md-offset-4">
      <h1>Vous voilà prêt à conquérir les internets !"</h1>
    </div>
  </div>
</div>
```

![Création du ficher index.html](blog_image_path tuto-gh-pages-4.jpg)

De retour sur votre application GitHub vous observerez quelques changements. La liste des fichiers présents dans votre *repository* est apparue à gauche alors que le code associé à chacun d'entre eux vous est présenté sur la droite.

![Contenu des fichiers sur GitHub Mac](blog_image_path tuto-gh-pages-5.jpg)

Prenez une photographie de votre travail en nommant et en enregistrant votre premier *commit*.

**Important:** A chaque fois que vous effectuerez cette action, une sorte de checkpoint sera créé. Par la suite, GitHub suivra l'évolution de votre code de manière incrémentale en vous signalant via un code couleur (vert/rouge) les lignes modifiées et/ou ajoutées. À vous de *commiter* régulièrement dès que vous installerez une nouvelle feature !

![Vos premiers commit](blog_image_path tuto-gh-pages-6.jpg)

Pour le moment vos changements sont uniquement visibles en local. Afin de partager vos créations sur le web, cliquez sur le bouton **Synchroniser** en haut à droite. Une fenêtre apparaîtra afin de vous inviter à nommer votre projet. Par défaut, celui-ci prend le nom du dossier. Cliquez ensuite sur *Push* pour envoyer et stocker vos fichiers en ligne sur GitHub.

![Pushe du votre site sur le web](blog_image_path tuto-gh-pages-7.jpg)

Rendez-vous ensuite sur : ```http://github.com/VOTRE_NOM_GITHUB/VOTRE_PROJET``` afin de vous assurez que l'ensemble de vos fichiers soient bien présents.

Pour visualiser votre site, rendez-vous sur ```http://VOTRE_NOM_GITHUB.github.io/VOTRE_PROJET```

Vous voilà désormais à la tête d'un site en ligne !

Pour donner un peu plus de cachet à tout cela et rajouter de nouveaux éléments, n'hésitez pas à consulter le tuto de Boris, CEO du Wagon, [The one hour landing page](http://www.lewagon.org/blog/the-one-hour-landing-page) afin d'attaquer HTML, CSS et Bootstrap en 2 heures de temps.

Partagez vos créations dans les commentaires ci-dessous ou via Twitter en mentionnant [@LeWagonParis](https://twitter.com/lewagonparis) !
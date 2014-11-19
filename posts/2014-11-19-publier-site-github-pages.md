---
layout: post
title: "Github pages et le repo magique"
author: cedric
labels:
  - tuto
thumbnail:
description: Vous souhaitez tester un idée ou mettre votre portfolio en ligne ? Alors ce tuto sur Github Pages est fait pour vous. En seulement quelques clics vous pourez héberger gratuitement votre site static et le partager au gré de vos envies.
---

Vous souhaitez tester un idée ou mettre votre portfolio en ligne ? Alors ce tuto sur Github Pages est fait pour vous. En seulement quelques clics vous pourez héberger gratuitement votre site static et le partager au gré de vos envies.

### Votre compte Github

Si vous ne connaissez pas encore Github, le service de collaboration entre developpeurs, nous vous recommandons de suivre [le tuto vidéo sur Git et Github](http://www.lewagon.org/blog/meetup-git-github) de [@ssaunier](https://twitter.com/ssaunier).

Commencez par vous créer un compte sur [GitHub](https://github.com/).

### Le Setup : GitHub for mac

Ensuite, au grand désespoir des fervents défenseurs du terminal (que nous sommes) téléchargez [GitHub Mac](https://mac.github.com/) ou [GitHub Windows](https://windows.github.com/).

Une fois l'application installée, connectez-là à votre compte fraîchement utilisé via votre nouveau login et password.

**Important** Pour la config Git, préciez absolument l'email que vous avez utilisé lors de la création de votre compte GitHub afin de permettre au service de bien votre travail à votre compte.

L'application cherchera des projets existants sur votre machine et sauf volonté de votre part, vous pouvez passer cette étape.

### Votre premier projet

Créez un dossier sur votre machine ```votre-projet-github-pages``` (notez bien que la dénomination du dossier reste complétement libre) et faites le glisser sur la fenêtre de l'application GitHub.

Un popup d'avertissement vous informera que ce projet n'est pas un répository (un projet dans le jargon Github) connu de votre compte. Validez.

**Important** Créez une nouvelle branche ```gh-pages``` sur votre projet en cliquant sur l'icone dédiée en haut à gauche.

A l'intérieur de votre dossier local, créez une page ```index.html``` et placez-y le code de [Boostrap Boilerplate](https://github.com/lewagon/bootstrap-boilerplate). Ce premier markup HTML initialise [le framework CSS Bootstrap](http://getbootstrap.com/css/) ce qui permettre de construire très simplement votre landing page.

Grace à votre editeur de texte préféré, ajouter un peu de texte sous la balise ```<body>```

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

De retour sur votre application GitHub vous devriez observer quelques changements. Une liste de fichiers est apparue sur la gauche alors que la partie de droite contient le code associé.


L'idée est de prendre une photographie de notre travail et d'éffectuer un commit. A chaque fois que vous effecturez cette action, une sorte de checkpoint sera créé. Nommer et enregistrez votre premier commit. Par ma suite, GitHub suivra l'évolution de votre code de manière incrémentale en vous signalant via un code couleur les lignes modifiées et/ou ajoutées. A vous de commiter régulièrement dès qu'une nouvelle feature est mise en place !

Pour le moment vos changements sont uniquement visibles en local. Afin de partager vos création sur le web, cliquez sur le bouton **Synchorniser** en haut à droite. Une fenêtre apparait afin de nommer votre projet. Par défault, celui-ci prend le nom du dossier. Cliquez ensuite sur Push afin de permettre à l'application d'envoyer et de stocker vos fichiers en ligne sur GitHub.

Rendez-vous ensuite sur : http://github.com/**VOTRE_NOM_GITHUB**/**VOTRE_PROJET** afin de vous assurez que l'ensemble des fichiers soient bien présent.

Pour visualiser votre site rendez-vous sur http://**VOTRE_NOM_GITHUB**.github.io/**VOTRE_PROJET**

Exemple : http://lewagon.github.io/votre-projet-github-pages

Voilà désormais à la tête d'un site en ligne !

A vous de l'améliorer et de rajouter de nouveau éléments. N'hésitez pas à consulter le tuto [The one hour landing page](http://www.lewagon.org/blog/the-one-hour-landing-page) afin d'attaquer HTML, CSS et Bootstrap en 2 heures de temps.


### Customisez votre nom de domaine



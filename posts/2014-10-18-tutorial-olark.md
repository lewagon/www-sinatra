---
layout: post
title: "Olark, le live-chat is back"
author: cedric
labels:
  - tuto
thumbnail: thumbnail-olark.jpg
description: "Excellent service très simple à installer, Olark vous permet d’avoir accès en temps réel aux feedbacks de vos visiteurs et/ou utilisateurs via un simple petit module de chat présent sur toutes les pages de votre plateforme. Si vous êtes absent ? Pas de soucis, vos interlocuteurs ont la possibilité de vous laisser un message. Une fois en place et customisé aux couleurs de votre service, cet outil deviendra certainement un incontournable dans la gestion de votre relation client."
---

![Olark Chat box](blog_image_path olark-wagon.jpg)

Excellent service très simple à installer, **Olark** vous permet d’avoir accès en temps réel aux *feedbacks* de vos visiteurs et/ou utilisateurs via un simple petit module de *chat* présent sur toutes les pages de votre plateforme. Si vous êtes absent ? Pas de soucis, vos interlocuteurs ont la possibilité de vous laisser un message. Une fois en place et customisé aux couleurs de votre service, cet outil deviendra certainement un incontournable dans la gestion de votre relation client.

###Convention over configuration : un setup en 3 étapes

**Étape 1 :** Rendez-vous sur [www.olark.com](http://www.olark.com) et inscrivez-vous (attention, trouver un username sympathique et acoustiquement agréable à vos oreilles peut demander un certain temps).

**Étape 2 :** [Copiez le script affiché](https://www.olark.com/install) et collez-le directement au-dessus de la balise ```</body> ``` de votre fichier *index.html* . Rafraîchissez votre page et automatiquement une petite box de chat en bas à droite de votre écran va apparaître.

![Setup Olark](blog_image_path olark-setup.jpg)

**Étape 3 :** Rendez-vous sur le dashboard de l’application et jetez un oeil aux options de customisation de votre *chat-box*. Une fois terminé, basculez sur [chat.olark.com](https://chat.olark.com/) et commencez à discuter avec vos utilisateurs / clients / visiteurs. C’est aussi simple que cela !

![Admin Olark](blog_image_path olark-admin.jpg)

**Le supplément**

Histoire de pousser le vice, regardez [leurs excellents tutos](https://www.olark.com/help/clients) afin de pouvoir continuer à échanger avec vos visiteurs lors de vos déplacements. Les utilisateurs d’iOS sont invités à utiliser l’application tierce [Trillian](https://itunes.apple.com/us/app/trillian/id327603487?mt=8) alors que les amateurs d'Androïd trouveront leur bonheur du côté de [Xabber](https://play.google.com/store/apps/details?id=com.xabber.android&hl=en) avant de paramétrer leur compte Olark en seulement quelques secondes.

###Infos pratiques

**En terme de performances**, Olark utilise une technologie basée sur *LightningJS* et n'a aucun impact sur le temps de chargement de votre page.

**Au niveau de la customisation**, le *css* n’est pas accessible sauf si vous choisissez l’option payante. Cela dit, le design actuel respecte les standards du web courant et devrait s’intégrer facilement à votre site. A noter également que l’intégralité des textes peuvent être édités et personnalisés afin de traduire la *chat-box* selon la localisation de vos visiteurs.

**Pour les plus data-drivés d’entre vous**, il est possible de suivre le nombre d’actions et d'événements générés sous Olark via Google Analytics. Pour en savoir plus, jetez un oeil sur la documentation : [help.olark.com](https://www.olark.com/help)

###Le truc à savoir

Si vous utilisez [Github pour déployer votre site](https://www.youtube.com/watch?v=V6Zo68uQPqE), n'oubliez pas de prendre vos dispositions. En effet, vos *credentials* Olark se trouvent dans le script inséré dans votre page *html* ! Pour la petite anecdote, un membre du Wagon s'est retrouvé un beau jour avec un trafic conséquent en provenance de Corée après qu'un dev originaire de là-bas ait tout simplement forké son *repository*.

Si vous découvrez ce service ou si vous avez quelques retours d'expériences et *best practice* à partager, n'hésitez pas à le faire sur [notre page Facebook](https://www.facebook.com/lewagonformation) ou en nous [mentionnant sur Twitter](https://www.twitter.com/lewagonparis).
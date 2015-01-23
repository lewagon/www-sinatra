---
layout: post
title: "Tout ce que vous avez toujours voulu savoir sur les APIs"
author: cedric
labels:
  - meetup
  - video
thumbnail: thumbail-api-webhook-tutorial.jpg
description: "Les APIs sont légions sur le web et offrent simplement et rapidement la possibilté de démultiplier la force de vos applications. De la définition de l'acronyme en passant par les Webhooks et quelques exemples d'utilisations, Sebastien Saunier vous invite à découvrir les bases de ce nouvel enjeux stratégique pour votre business. "
---

Les APIs sont légions sur le web et offrent simplement et rapidement la possibilté de démultiplier la force de vos applications. De la définition de l'acronyme en passant par les Webhooks et quelques exemples d'utilisations, [Sebastien Saunier](https://twitter.com/ssaunier) CTO du Wagon, vous invite à découvrir les bases de ce nouvel enjeux stratégique pour votre business.

<div class="video-wrapper"><iframe width="750" height="422" src="//www.youtube.com/embed/0FQ6w4CO5Nw?rel=0&amp;controls=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe></div>

###Qu'est-ce qu'une API ? (*Application Programming Interface*)

Les APIs sont des interfaces créées par des développeurs qui sont utilisées par des programmes (ordinateurs, robots, code...) afin d'intéréagir (connecter) et d'excuter des tâches avec des applications web tiers. [Programmableweb](http://www.programmableweb.com) référence toutes les APIs par ordre de popularité.

*Exemples :* AirBnB utilise l'API Google Map pour de placer des markers customisés sur une carte afin de localiser les appartements ouverts à la location. L'API de YouTube permet d'embed des vidéos sur n'importe quel site à l'instar de celle ci-dessus.

**Important**: Une API **expose** des services. Un programme **consomme** une API.

###Mais comment ça marche ?

En temps normal, lorsqu'un utilisateur rentre une donnée dans la bar de recherche de son navigateur, il effecture une simple requête html à laquelle un serveur répondra par une vue `html`. C'est exactement le même fonctionnement pour les APIs. Le serveur de l’application interroge l’API d'un service qui lui retourne bien souvent des données sous la forme d'un `JSON` qui seront stockées dans une base de données afin d'être retournées sur un vue `html`.

*Exemple :* Lorsque vous interrogez l'API de Google Maps pour obtenir la localisation précise du 25 rue du petit Musc vous effectuez une requête via : [https://maps.googleapis.com/maps/api/geocode/json?address=25 rue du petit musc](https://maps.googleapis.com/maps/api/geocode/json?address=25 rue du petit musc).

###Et le WebHook dans tout ça ?

Le plus souvent les pages web sont statiques (ex : cet article). Dans le cas ou le contenu est à même d'être mis à jour, il semblerait peu efficace d’envoyer des requêtes à répétition pour obtenir son refresh. Une communication ascendante et descendante entre l'API et votre service est alors indispensable. C'est ici que la notion de WebHook intervient :

- L'API push des données dès qu’elle sont disponibles
- Le service B expose des méthodes pour écouter les requêtes pushées par l'API

###Il y a t-il des restrictions ?

Deux restrictions princpales sont à prendre en compte :

- Il vous est possible de consommer l’API mais **jamais de modifier** la manière dont elle interagi
- Les APIs ont aussi leur propre système d’authentification et vous impose généralement d’inclure dans votre code les credentials (clé et mot de passe) afin de limiter le nombre d’appels ou de facturer leur service

###Les slides de la présentation

<div class="video-wrapper"><iframe src="//www.slideshare.net/slideshow/embed_code/42874896" width="750" height="422" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe></div>

### Liens utiles

- [Zappier](https://zapier.com/)
- [Programmableweb](http://www.programmableweb.com )

###Reminder

Ne ratez plus un seul de nos événements Tech et rejoignez [la communauté Meetup du Wagon](http://www.meetup.com/Le-Wagon-Paris-Coding-Station/)

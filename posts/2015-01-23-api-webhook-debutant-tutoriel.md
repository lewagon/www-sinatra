---
layout: post
title: "Tout ce que vous avez toujours voulu savoir sur les APIs"
author: cedric
labels:
  - meetup
  - tuto
  - video
pushed: true
thumbnail: thumbail-api-webhook-tutorial.jpg
description: "Les APIs sont légions sur le web et offrent simplement et rapidement la possibilité de démultiplier la force de vos applications. De la définition de l'acronyme en passant par la notion de webhook et quelques exemples d'utilisations, Sebastien Saunier, CTO du Wagon, vous invite à découvrir les bases de ce nouvel enjeu stratégique pour votre projet."
---

<div class="video-wrapper"><iframe width="750" height="422" src="//www.youtube.com/embed/0FQ6w4CO5Nw?showinfo=0" frameborder="0" allowfullscreen></iframe></div>

Les APIs sont légion sur le web et offrent simplement et rapidement la possibilité de démultiplier la force de vos applications. De la définition de l'acronyme en passant par la notion de webhook et quelques exemples d'utilisations [Sebastien Saunier](https://twitter.com/ssaunier), CTO du Wagon, vous invite à découvrir les bases de ce nouvel enjeu stratégique pour votre projet.

###Qu'est-ce qu'une API ? (*Application Programming Interface*)

Les APIs sont des interfaces créées par des développeurs. Elles sont utilisées par des programmes (ordinateurs, robots, code...) afin de se connecter, d'interagir puis d'exécuter des tâches avec des applications web tierces. Pour les plus curieux d'entre vous [Programmableweb](http://www.programmableweb.com) référence toutes les APIs par ordre de popularité.

*Exemples :* AirBnB utilise l'API Google Maps pour placer des marqueurs customisés sur une carte afin de localiser les appartements ouverts à la location. L'API de YouTube permet d'intégrer des vidéos hébergées sur sa plateforme sur n'importe quel site, comme la vidéo ci-dessus par exemple.

**IMPORTANT:** Une API **expose** des services. Un programme **consomme** une API.

###Mais comment ça marche ?

En temps normal, lorsqu'un utilisateur rentre une donnée dans la barre de recherche de son navigateur, il lance une requête `http` à laquelle un serveur répondra par une vue `html`. C'est exactement le même fonctionnement pour les APIs. Le serveur de l’application interroge l’API d'un service via une requête `http` qui lui retourne le plus souvent des données sous la forme d'un `JSON` (type de fichier spécifique dans lequel les données sont représentées sous forme de tableau) qui seront stockées dans une base de données afin d'être retournées sur la vue `html` du site.

*Exemple :* Lorsque vous interrogez l'API de Google Maps afin d'obtenir la localisation précise du 25 rue du petit Musc vous effectuez une requête via : [https://maps.googleapis.com/maps/api/geocode/json?address=25 rue du petit musc](https://maps.googleapis.com/maps/api/geocode/json?address=25 rue du petit musc).

###Et le WebHook dans tout ça ?

Le plus souvent les pages web sont statiques (ex : cet article). Cependant, dans le cas où le contenu consultable est susceptible d'être mis à jour (ex: timeline Twitter), il semble peu efficace d’envoyer des requêtes à répétition afin d'obtenir son refresh. Une communication ascendante et descendante entre l'API et votre service est alors indispensable. C'est ici que la notion de WebHook intervient :

- Le service externe contacte votre application lorsque du nouveau contenu est disponible (Hollywood principle, *don't call us, we'll call you*)
- Votre application expose des méthodes pour écouter les requêtes pushées par l'API du service externe et les traiter.

###Est-ce qu'il y a des restrictions ?

Deux restrictions principales sont à prendre en compte :

- Il vous est possible de consommer l’API mais **jamais de modifier** la manière dont elle interagit
- Les APIs ont leur propre système d’authentification et vous imposent généralement d’inclure dans votre code les *credentials* (clé et mot de passe) afin de limiter le nombre d’appels ou de facturer leur service

###Les slides de la présentation

<div class="video-wrapper"><iframe src="//www.slideshare.net/slideshow/embed_code/42874896" width="750" height="422" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe></div>

### Liens utiles

- [Zapier](https://zapier.com/)
- [Programmableweb](http://www.programmableweb.com )

###Reminder

Ne ratez plus un seul de nos événements Tech et rejoignez [la communauté Meetup du Wagon](http://www.meetup.com/Le-Wagon-Paris-Coding-Station/)
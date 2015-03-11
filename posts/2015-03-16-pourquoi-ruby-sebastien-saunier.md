---
layout: post
title: "Pourquoi apprendre à coder en Ruby ?"
thumbnail: pourquoi-ruby-sebastien-saunier.jpg
author: cedric
labels:
  - Startup
  - Misc
description: Pourquoi apprendre à coder en Ruby ? Question récurrente de la part de l'ensemble des interlocuteurs du Wagon, Sebastien Saunier, CTO du Wagon, se propose d'apporter quelques arguements explicatifs sur ce parti pris.
---

Pourquoi Ruby ? Question récurrente de la part de l'ensemble des interlocuteurs du Wagon, [Sebastien Saunier](https://twitter.com/ssaunier), CTO du Wagon, se propose d'apporter quelques arguements explicatifs sur ce parti pris.

![Pourquoi apprendre à coder en Ruby ?](blog_image_path pourquoi-ruby-sebastien-saunier.jpg)

## Peux-tu présenter en quelques lignes ?

J'ai commencé à hacker mes premiers sites PHP au lycée, au début des années 2000. À l'époque, il y avait peu de ressource, et mon activité de développeur amateur & autodidacte consistait à copier coller des bouts de code, scruter des Parse error et tenter de les fixer par essai / erreur dichotomique. Mon premier contrat freelance date de 2007 lorsque j'ai crée de toute pièce le site e-commerce de [Sogedis](http://pieces-detachees.sogedis.fr/).

Mon double diplôme [Polytechnique](http://www.polytechnique.edu/) / [Telecom ParisTech](http://www.telecom-paristech.fr) m'a permis d'avoir une culture Computer Science forte (Algoritmique, Modélisation, etc.) ainsi qu'une pratique du code avancée (C, C++, Bases de données, etc.). J'ai décroché un stage chez Google à Zurich ou j'ai pu développer pendant 8 mois avec les meilleurs ingénieurs de la planète. Je bossais sur un dashboard web du système de régulation interne des flux réseaux entre datacenters, en Python. Revenu en France en 2009, j'ai rejoint [VirtuOz](http://www.journaldunet.com/ebusiness/crm-marketing/nuance-acquiert-virtuoz-0113.shtml) et ai développé pendant 3 ans en C# sur la plateforme SaaS. En 2012-2013, j'ai travaillé pour [Applidget](http://www.applidget.com) en tant que lead developer sur la solution SaaS évenementielle [MobiCheckin](http://www.mobicheckin.com). Ce fut mon premier contact avec Ruby on Rails, et ce fut le coup de foudre.

## Pourquoi avoir fait de Ruby on Rails ta spécialité ?

Ruby on Rails est un outil unique et parfaitement adapté aux développement d'applications web. De nombreux startups devenus de grand succès du web ont commencé avec Rails (GitHub, Twitter, Shopify et Basecamp bien évidemment, etc.). Pour une startup, aller vite, pivoter, changer d'avis, faire et défaire fait partie du quotidien. Rails offre une flexibilité extraordinaire pour encaisser sans broncher tous ces changements.

Une des premières choses que j'aime avec Ruby est le langage en lui-même. Sa syntaxe est simple, proche du langage naturel (en langue anglaise). C'est vraiment un plaisir d'écrire du code dans ce langage. Son aspect dynamiquement typé le rend peu verbeux et très souple. Il ouvre la voie à la meta-programmation de manière unique, ce qui intellectuellement est très satisfaisant.

Toujours en gardant mon point de vue de développeur, le tool set associé à Ruby on Rails est le plus simple qui soit : un éditeur de texte, un terminal et un navigateur. C'est tout. Pas besoin d'IDE lourds comme Eclipse ou Visual Studio, votre ordi respire, il y a zéro temps perdu à regarder des [écrans de chargement](http://www.commitstrip.com/fr/2014/11/11/the-unexpected-default-program-2/).

Un aspect important de Rails est qu'il est basé sur le principe de Convention over Configuration. L'idée est que l'architecture des dossiers de votre code est normalisée, et rendue obligatoire par le framework. Il existe donc le rails way, ce qui permet à un développeur Rails de prendre en main en quelques heures n'importe quelle application, même s'il n'en a pas codé une ligne. Cet aspect peut décontenancer les développeurs venant d'un langage plus verbeux (comme Java), qui vont souvent poser la question, "où est le code ?". Il faut se faire à cette abstraction, et une fois les conventions internalisées, la vitesse de développement d'une nouvelle fonctionnalité est extraordinaire. Par exemple, j'ai pu développer la plateforme pédagogique du Wagon (une application Rails utilisée par les élèves du bootcamp fullstack pour prendre connaissance des exercices et analyser leurs performances en temps réelle) en un contrat de 20 heures. En moins de 3 jours, l'application était fonctionnelle, en production, prête à l'emploi.

Rails est une gem, c'est à dire un module open-source développé et maintenu depuis plus de 10 ans par des milliers de développeurs. En l'utilisant, on est vraiment sur les épaules d'un géant. Mais cela ne s'arrête pas là, il existe des [milliers de *gems*](https://rubygems.org/), d'ailleurs nous vous en avions présenté [25 récemment](http://www.lewagon.org/blog/25-gems-indispensables-pour-debuter-une-application-rails). Ainsi, lorsqu'une nouvelle fonctionnalité est à développer, dans 90% des cas le travail peu être réalisé rapidement en se basant sur un module existant. C'est bluffant.

La communauté Ruby a une culture d'ouverture et de partage depuis ses débuts. Le code est sur GitHub, si il manque quelque chose dans une gem, aucun soucis, il suffit de forker et d'ajouter soi-même la fonctionnalité pour son propre produit. Le move chic qui suit, c'est de faire une pull request au projet initial pour partager ce développement avec la communauté (give back). Cet esprit est formidable, sur le plan éthique / moral mais aussi économique, car les développeurs ruby ne **réinventent pas la roue**.

## Quels autres langages maîtrises-tu ? Comment s’articulent-ils entre eux ?

Le langage Ruby n'est pas suffisant lorsqu'on fait du développement web. Il faut maîtriser une stack plus complète, composée de :

HTML & CSS : ce ne sont pas des langages de programmation, mais de représentation de la donnée. C'est ce que le navigateur sait lire pour pouvoir afficher une page web (contenu et style)
JavaScript : c'est le langage de programmation que connaît le navigateur, qui permet de rendre les pages dynamiques. Par exemple, sur Gmail, les nouveaux emails apparaîssent automatiquement sans rafraîchir la page, et c'est grâce à JavaScript (et AJAX plus précisément)
SQL : c'est le langage de requête utilisé pour parler avec une base de donnée comme PostgreSQL. Une application web présente des données à l'utilisateur, et permet de les modifier (par exemple, Facebook affiche des posts dans un feed, et vous permet d'en créer de nouveaux), et c'est le rôle de la base de données de stocker tout cela. Il faut donc savoir lui poser des questions comme "Donne moi tous les posts de l'utilisateur 1893739".
Ruby : le language executé côté serveur (on parle de backend, par opposition au frontend composé de HTML/CSS/JavaScript), pour pouvoir utiliser Rails.
C'est ma stack quotidienne. Il m'arrive également de coder encore un peu en PHP et en C# car je maintiens l'e-commerce et l'intranet de [Sogedis](http://www.sogedis.fr).

## Un petit mot au sujet de ton workflow quotidien ?

Je fais une utilisation intensive de GitHub, et nottament du [GitHub flow](http://scottchacon.com/2011/08/31/github-flow.html). Dès que l'on travail sur du texte (code ou prose), je trouve que c'est toujours un bon choix de versionner et d'utiliser git, même si on est seul. C'est un formidable outil et GitHub l'a sublimé en apportant au dessus une couche sociale ainsi que des outils de collaboration formidables.

Je développe sur mon Macbook Pro avec Sublime Text, le Terminal et Firefox. J'ai standardisé mon [setup](https://github.com/lewagon/setup) et ma [config](https://github.com/lewagon/dotfiles) pour que chaque élève du Wagon puisse bénéficier d'une machine opérationnelle et rapide. C'est important de pouvoir aller aussi vite que sa pensée (je parle de la frappe du clavier ainsi que le switch de fenêtes entre l'éditeur, le terminal et le navigateur). Je ne tolère vraiment aucune lenteur sur ma machine, c'est pourquoi je vous conseille de [passer sur SSD](https://www.youtube.com/watch?v=sLe66QlKbsk) si votre vieux Macbook est un peu lent.

## Pourquoi avoir choisi d’enseigner ?

Je suis arrivé au Wagon en tant que prof sur la toute première promo, pour les deux dernières semaines. À l'époque, je venais de me lancer en tant que développeur & consultant freelance, et Le Wagon était l'un de mes premiers contrats. Sceptique au début sur la capacité à transmettre en 9 semaines ce que j'avais mis des années à acquérir (par moi-même et en école d'ingénieur), j'ai été bluffé par les résultats obtenus. De plus, les profils entrepreneurs des élèves du Wagon amènent une grande diversité dans les projets, et challengent en permanence mes compétences techniques. Rafraîchissant !

J'ai donc décidé de rempiler pour la Promo 2, et parparticipé à l'amélioration des supports de cours (exercices de code en TDD). Condenser en 9 semaines tout la technique pour être autonome sur son site web s'est averé possible grâce à cet aspect très pratique de la formation (90% du temps est passé à coder, 10% en cours "magistral"). Enseigner le code, c'est partager ma passion de construire ex nihilo, c'est ressentir un grand sentiment d'accomplissement lorsque ça fait "tilt" chez les élèves. Avec le recul, la passion est toujours là, et voir le chemin parcouru par les alumni me conforte dans mon choix de rejoindre le Wagon en tant que CTO. *Let's build our world!*
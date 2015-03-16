---
layout: post
title: "Pourquoi apprendre à coder en Ruby ?"
thumbnail: pourquoi-ruby-sebastien-saunier.jpg
author: cedric
labels:
  - Startup
  - Misc
description: Pourquoi apprendre à coder en Ruby ? Question récurrente de la part de l'ensemble des interlocuteurs du Wagon, Sébastien Saunier, CTO du Wagon, se propose d'apporter quelques arguments explicatifs sur ce parti pris.
---

Pourquoi Ruby ? Question récurrente de la part de l'ensemble des interlocuteurs du Wagon, [Sébastien Saunier](https://twitter.com/ssaunier), CTO du Wagon, se propose d'apporter quelques arguments explicatifs sur ce parti pris.

![Pourquoi apprendre à coder en Ruby ?](blog_image_path pourquoi-ruby-sebastien-saunier.jpg)

## Peux-tu présenter en quelques lignes ?

J'ai commencé à hacker mes premiers sites PHP au lycée, au début des années 2000. À l'époque, il y avait peu de ressource, et mon activité de développeur amateur & autodidacte consistait à copier coller des bouts de code, scruter des *Parse error* et tenter de les fixer par essai / erreur et tranchage de code dichotomique. Mon premier contrat freelance date de 2007 lorsque j'ai créé *from scratch* le site e-commerce de [Sogedis](http://pieces-detachees.sogedis.fr/).

Mon double diplôme [**Polytechnique**](http://www.polytechnique.edu/) / [Telecom ParisTech](http://www.telecom-paristech.fr) m'a permis d'acquérir une culture *Computer Science* forte (Algoritmique, Modélisation, etc.) ainsi qu'une pratique du code avancée (C, C++, Bases de données, Réseau, etc.). J'ai décroché un stage chez **Google** à Zurich ou j'ai pu développer pendant 8 mois avec les meilleurs ingénieurs de la planète. Je bossais sur un dashboard web du système de régulation interne des flux réseaux entre datacenters, en Python. Revenu en France en 2009, j'ai rejoint [VirtuOz](http://www.journaldunet.com/ebusiness/crm-marketing/nuance-acquiert-virtuoz-0113.shtml) et ai développé pendant 3 ans en C# sur la plateforme SaaS. En 2012-2013, j'ai travaillé pour [Applidget](http://www.applidget.com) en tant que lead developer sur la solution SaaS évenementielle [MobiCheckin](http://www.mobicheckin.com). Ce fut mon premier contact avec Ruby on Rails, et ce fut le coup de foudre.

## Pourquoi avoir fait de Ruby on Rails ta spécialité ?

Ruby on Rails est un outil unique et parfaitement adapté aux développement d'applications web. De nombreuses startups devenues de grand succès du web ont commencé et continuent avec Rails (**GitHub**, Twitter, Shopify et Basecamp bien évidemment, etc.). Pour une startup, aller vite, pivoter, changer d'avis, faire et défaire fait partie du quotidien. Rails offre une flexibilité extraordinaire pour encaisser sans broncher tous ces changements.

Une des premières choses que j'aime avec Ruby est le langage en lui-même. Sa syntaxe est simple, proche du langage naturel (en langue anglaise). C'est vraiment un plaisir d'écrire du code dans ce langage. Son aspect dynamiquement typé le rend peu verbeux et très souple. Il ouvre la voie à la **meta-programmation** de manière unique, ce qui intellectuellement est très satisfaisant.

Toujours en gardant mon point de vue de développeur, le *tool set* associé à Ruby on Rails est le plus simple qui soit : un éditeur de texte, un terminal et un navigateur. C'est tout. Pas besoin d'*IDE* lourds comme Eclipse ou Visual Studio, votre ordi respire, il y a zéro temps perdu à regarder des [écrans de chargement](http://www.commitstrip.com/fr/2014/11/11/the-unexpected-default-program-2/).

Un aspect important de Rails est qu'il est basé sur le principe de ***Convention over Configuration***. L'idée est que l'architecture des dossiers de votre code est normalisée, et rendue obligatoire par le framework. Il existe donc le ***rails way***, ce qui permet à un développeur Rails de prendre en main en quelques heures n'importe quelle application, même s'il n'en a pas codé une ligne. Cet aspect peut décontenancer les développeurs venant d'un langage plus verbeux (comme Java), qui vont souvent poser la question, "où est le code ?". Il faut se faire à cette abstraction, et une fois les conventions internalisées, la vitesse de développement d'une nouvelle fonctionnalité est extraordinaire. Par exemple, j'ai pu développer la plateforme pédagogique du Wagon (une application Rails utilisée par les élèves du bootcamp fullstack pour prendre connaissance des exercices et analyser leurs performances en temps réelle) en un [**contrat de 20 heures**](http://sebastien.saunier.me/blog/2013/10/17/realite-financiere-du-freelance-ruby-on-rails.html). En moins de 3 jours, l'application était fonctionnelle, en production, prête à l'emploi.

Rails est une *gem*, c'est à dire un module open-source, développé eet maintenue depuis plus de 10 ans par des [milliers de développeurs](https://github.com/rails/rails/graphs/contributors). En l'utilisant, on est vraiment sur les épaules d'un géant. Mais cela ne s'arrête pas là, il existe des [milliers de *gems*](https://rubygems.org/), d'ailleurs nous vous en avions présenté [25 récemment](http://www.lewagon.org/blog/25-gems-indispensables-pour-debuter-une-application-rails). Ainsi, lorsqu'une nouvelle fonctionnalité est à développer, dans 90% des cas le travail peu être réalisé rapidement en se basant sur un module existant. C'est bluffant.

La communauté Ruby a une culture d'ouverture et de partage depuis ses débuts. Le code est sur GitHub, si il manque quelque chose dans une gem, aucun soucis, il suffit de *forker* et d'ajouter soi-même la fonctionnalité pour son propre produit. Le move chic qui suit, c'est de faire une **pull request** au projet initial pour partager ce développement avec la communauté (give back). Cet esprit est formidable, sur le plan éthique / moral mais aussi économique, car les développeurs ruby ne **réinventent pas la roue**.

## Pourquoi Ruby on Rails pour le bootcamp du Wagon ?

Tout d'abord, il faut noter que Ruby on Rails est un bon choix pour le bootcamp, mais pas exclusif. Selon nos critères de choix, Python/Django pourrait très bien faire le boulot.

Rails est un *framework*, c'est-à-dire un cadre dans lequel le développeur doit s'inscrire. Ce cadre est très *opiniated* dans le cas de Rails, ce qui veut dire que dans 99% des situations, il y a un *rails way*. Cela permet donc de collaborer facilement, et facilite l'apprentissage. Cela peut être vu comme une contrainte, mais avec l'expérience un développeur sait bien qu'il y a 1000 moyens de résoudre un problème. Ne pas avoir à faire constamment ce choix est [reposant](https://www.psychologytoday.com/blog/more-tech-support/201011/the-burden-choice). Et il saura s'écarter du *rails way* dans des situations très spécifiques, ce qui est possible avec Rails.

Le Wagon est une école de code pour entrepreneurs, et quel que soit le domaine dans lequel les élèves souhaitent s'investir, ils ont toujours le même besoin : une base de données avec un *front* web (une **application** web), et pour Rails, c'est vraiment le *sweet spot*. Même dans le cas d'une application mobile, il faut un *back-end* (par exemple pour stocker les scores d'un joueur si on développe un jeu), et Rails permet de rapidement en construire un.

Les nombreuses gems disponibles dans l'écosystème rails sont un réel plus. Encore une fois, les besoins techniques des élèves du Wagon se résument à un ensemble bien précis : *login* (email ou Facebook), sécurité, *emailing*, paiement, *upload* d'images, recherche, etc. Au final, le boulot du développeur est de bien comprendre comment intégrer au mieux ces **briques** existantes et se concentrer sur **les besoins business** des utilisateurs / clients.

Concernant le marché de l'emploi, Ruby n'est pas le premier langage recherché. En fait la majorité des boulots se trouvent dans le monde *corporate* ou Java et C# sont les rois. Cependant, beaucoup de startup font confiance à Ruby on Rails, et nous avons des exemples d'alumni qui ont pu trouver un poste de junior developer à Paris. De manière générale, il ne faut pas se focaliser sur un langage en particulier. En effet, je n'ai pas démarré avec Ruby, et je ne finirai sans doute pas ma carrière avec. Turing nous a montré que tous les langages sont équivalents en terme d'expressivité, ce qui veut dire qu'une fois que vous savez programmer dans un langage, vous savez programmer dans tous les langages. Le plus dur est d'acquérir le *mindset* de programmeur, ce que le bootcamp permet en un temps record. Ensuite, si un job vous demande de coder dans un autre langage, prenez une semaine pour vous mettre à fond dessus. Vous ferez rapidement l'analogie syntaxique entre votre langage préféré et ce nouveau, car les concepts de base sont identiques. D'ailleurs, pendant le bootcamp, un tel report de connaissance a déjà lieu car nous abordons **JavaScript** en cinquième semaine, un autre langage de programmation que Ruby.

## Quels autres langages maîtrises-tu ? Comment s’articulent-ils entre eux ?

Le langage Ruby n'est pas suffisant lorsqu'on fait du développement web. Il faut maîtriser une stack plus complète, composée de :

- **HTML & CSS** : ce ne sont pas des langages de programmation, mais de représentation de la donnée. C'est ce que le navigateur sait lire pour pouvoir afficher une page web (contenu et style)
- **JavaScript** : c'est le langage de programmation que connaît le navigateur, qui permet de rendre les pages dynamiques. Par exemple, sur Gmail, les nouveaux emails apparaîssent automatiquement sans rafraîchir la page, et c'est grâce à JavaScript (et AJAX plus précisément)
- **SQL** : c'est le langage de requête utilisé pour parler avec une base de donnée comme PostgreSQL. Une application web présente des données à l'utilisateur, et permet de les modifier (par exemple, Facebook affiche des posts dans un feed, et vous permet d'en créer de nouveaux), et c'est le rôle de la base de données de stocker tout cela. Il faut donc savoir lui poser des questions comme "Donne moi tous les posts de l'utilisateur 1893739".
- **Ruby** : le language executé côté serveur (on parle de backend, par opposition au frontend composé de HTML/CSS/JavaScript), pour pouvoir utiliser Rails.

C'est ma stack quotidienne. Il m'arrive également de coder encore un peu en PHP et en C# car je maintiens l'e-commerce et l'intranet de [Sogedis](http://www.sogedis.fr).

## Un petit mot au sujet de ton workflow quotidien ?

Je fais une utilisation intensive de GitHub, et nottament du [GitHub flow](http://scottchacon.com/2011/08/31/github-flow.html). Dès que l'on travail sur du texte (code ou prose), je trouve que c'est toujours un bon choix de versionner et d'utiliser git, même si on est seul. C'est un formidable outil et GitHub l'a sublimé en apportant au dessus une couche sociale ainsi que des outils de collaboration formidables.

Je développe sur mon Macbook Pro avec Sublime Text, le Terminal et Firefox. J'ai standardisé mon [setup](https://github.com/lewagon/setup) et ma [config](https://github.com/lewagon/dotfiles) pour que chaque élève du Wagon puisse bénéficier d'une machine opérationnelle et rapide. C'est important de pouvoir aller aussi vite que sa pensée (je parle de la frappe du clavier ainsi que le switch de fenêtes entre l'éditeur, le terminal et le navigateur). Je ne tolère vraiment aucune lenteur sur ma machine, c'est pourquoi je vous conseille de [passer sur SSD](https://www.youtube.com/watch?v=sLe66QlKbsk) si votre vieux Macbook est un peu lent.

## Pourquoi avoir choisi d’enseigner ?

Je suis arrivé au Wagon en tant que prof sur la toute première promo, pour les deux dernières semaines. À l'époque, je venais de me lancer en tant que développeur & consultant freelance, et Le Wagon était l'un de mes premiers contrats. Sceptique au début sur la capacité à transmettre en 9 semaines ce que j'avais mis des années à acquérir (par moi-même et en école d'ingénieur), j'ai été bluffé par les résultats obtenus. De plus, les profils entrepreneurs des élèves du Wagon amènent une grande diversité dans les projets, et challengent en permanence mes compétences techniques. Rafraîchissant !

J'ai donc décidé de rempiler pour la Promo 2, et parparticipé à l'amélioration des supports de cours (exercices de code en TDD). Condenser en 9 semaines tout la technique pour être autonome sur son site web s'est averé possible grâce à cet aspect très pratique de la formation (90% du temps est passé à coder, 10% en cours "magistral"). Enseigner le code, c'est partager ma passion de construire *ex nihilo*, c'est ressentir un grand sentiment d'accomplissement lorsque ça fait "tilt" chez les élèves. Avec le recul, la passion est toujours là, et voir le chemin parcouru par les alumni me conforte dans mon choix de rejoindre le Wagon en tant que CTO. *Let's build our world!*
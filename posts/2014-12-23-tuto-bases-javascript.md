---
layout: post
title: "Javascript pour les débutants"
author: cedric
labels:
  - meetup
  - tuto
  - video
thumbnail:
description: Gilles Manzato vous présente les bases de Javascript, jQuerry et le principe des requêtes AJAX dans ce tuto vidéo d'une heure. Des plus simples variables à la notion de callback, vous apprendrez quelques notions rapidement utilisables pour vos projets personnels du moment.
---

Gilles Manzato vous présente les bases de Javascript, jQuerry et le principe des requêtes AJAX dans ce tuto vidéo d'une heure. Des plus simples variables à la notion de callback, vous apprendrez quelques notions rapidement utilisables pour vos projets personnels du moment.

<div class="video-wrapper"><iframe width="750" height="422" src="//www.youtube.com/embed/ZEtyr9C01cg?rel=0&amp;controls=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe></div>

### Un peu d'histoire

La Javascript, à ne pas confondre avec Java, est un langugage web orienté objet créé en 1985 utilisé à la fois pour créer des pages web interactives (il s'interface avec le HTML et le CSS) mais également du côté serveur. Il y'a encore 10 ans le Javascript était encore peu utilisé mais les récentes évolutions des navigateurs web ont boosté les performances de ce language avec un gain de performance de l'ordre de 1 à 1000 depuis IE6 a Chrome. L'arrivée du framework jQuerry, dont nous parlerons plus tard, a également favorisé son expansion.

### Le Setup

Pour suivre ce tutorial vous aurez besoin du [navigateur Chrome](http://www.google.com/chrome/) installé afin d'utiliser la [console](https://developer.chrome.com/devtools/docs/console). Ouvrez également [jsFiddle](http://jsfiddle.net/) dans un onglet pour tester votre code rapidement.

Pour ouvrir la *console*, utilisez les racourcis suivants :
- Sur Windows : Ctrl + Maj + J
- Sur Mac : Cmd + Opt + I

**Important :** Pour des raisons de sécurité la console JS est isolée et liée à la durée de vie de la page. Au cours des excercices ne rafraîchissez pas la page sous peine de tout devoir recommencer !

### Les bases


=> Variables

var mavariable = 8;
Attention, toujours terminer une ligne en la ponctuant d’un ;
Pour la récupérer il suffit de la nommer afin de récupérer la donnée stockée

Si vous souhaitez changer la donnée associée à la variable, il suffit ensuite d’écrire mavariable = “hello”; sans le var

Différents types de données : chiffres, string (texte entre guillemets) et boolean (binaire, true/false, 0/1)

> typeof(mavariable); retourne String

Des opérateurs arithmétiques au différents types de variables possibles en passant par la concaténation.

> Modulo (%) donne le reste ex = 9%2 = 1 pour l’interpréter = on peut placer 4*2 soit 8 dans 9 donc reste 1

Les conditions if, else

var nombre = 10;
if(nombre >= 5){
  console.log(‘plus grand que 5’)
}
else {
  console.log(‘plus petit que 5’)
}

nb : console.log permet de ne pas utiliser le popup alert() et d’afficher le résultats de vos actions dans la console.

=> If n’est pas obligatoirement suivi d’un else. Il est possible de s’en servir seul afin de vérifier une condition en renvoyant true ou false

if(3 < 5){console.log(“vrai”) }

Les fonctions : Un bout de code que l’on va pouvoir réutiliser plus tard afin de lui demander d’exécuter certains actions.

var mafonction = function(name){
  return “Bonjour “ + name;
}

En passant l’argument Gilles à ma fonction mafunction(“Gilles”) retournera la string "Bonjour Gilles’

Donc var mareponse = mafunction(“Gilles”);
mareponse
"Bonjour Gilles”

———————————————

Le jQuery

Le javascript utilise le DOM pour communiquer avec la page. Mais le DOM n’est pas standardisé entre les navigateurs. jQuery synthétise tout cela et propose une multitudes de fonctions qui s’appuient sur les sélecteurs CSS.

Le $ permet d’accéder directement à l’objet jQuery

<div id=“monid”>Hello world !</div>

$(“#monid”).text(“Bonjour”);

=> Phase en deux temps, le navigateur commence par lire l’html et à ensuite remplacé le contenu de la div par le code jQuery,

Le javascript n’est pas utilisé pour faire un travail de mise en page. Il sert à faire des choses complexe et/ou impossible en css en terme d’événements et d’animations.

<button class=“monbouton”>View spoiler</button>

Le Javascript permet par exemple d’envoyer des informations à un serveur (envoi d’un formulaire par exemple) tout en restant sur la même page sans la recharger et de faire autre chose.

Les animations

<p class=“spoiler”>Text de trucs</p>

.spoiler { display : none; }

$('.monbouton’).on(‘click’, function(){
  $(‘.spoiler’).slideToggle();
})

toggle = Afficher/Cacher

=> Attendre que l’utilisateur lance un événement pour lancer un callback = une fonction appelée lorsque l’utilisateur lance un événement (appuyer sur un bouton)

=> Possibilité de chainer les actions !
$('.monbouton’).on(‘click’, function(){
  $(‘.spoiler’).show().animate({opacity:0.5}, 1000);
})

———————————————

AJAX

La possibilité de faire des requêtes asynchrones vers des données externes ou internes du site sans jamais recharger la page. La plus part du temps, on va chercher des données stockées sous forme de JSON : un objet Javascript facile à accéder, qui ne prend pas de temps pour les applications et donc n’impact pas les performances.

Exemple :

{
   "4": {
      "id": "4",
      "first_name": "Mark",
      "gender": "male",
      "last_name": "Zuckerberg",
      "link": "https://www.facebook.com/zuck",
      "locale": "en_US",
      "name": "Mark Zuckerberg",
      "username": "zuck"
   },
}

<p></p>
<button>Go get Zack</button>

$(‘button’).on(‘click’, function(){
  $.getJSON('http://graph.facebook.com/4').success(function(data){
  console.log(“AJAX Success”);
  console.log(data.first_name)
  $(“p”).text(data.first_name + “ “ data.last_name);
  })
})

———————————————

EACH - Il récupère chaque item d’un ensemble de données et applique une fonction a chacun d’entre eux.

<p></p>
<button>Go get Zack</button>

$(‘button’).on(‘click’, function(){
  $.getJSON('http://graph.facebook.com/?ids=4,5,6')
  .success(function(data){
    //console.log(“AJAX Success”);
    //console.log(data.first_name)
    $.each(data, function(index, item){
      $(“p”).append(data.first_name + “ “ + data.last_name + “<br >")
    });
  })
})

A voir :
Notion d’index
Append

Quand il boucle, il donne un index à chaque itération selon les IDs attribuées.

———————————————
Validation de formulaire

<label>Adresse email :</label><input class=“email”></input>
<button>Subscribe</button>
<p class=“valide"></p>

$(‘button’).on(‘click’, function(){
  if($(“.email”).val() == “”) {
    $(“.valide”).text(“Vide”);
    $(“.email”).css(“border”, 1px solid red”);
  }
  else {
    $(“.valide”).text(“Valide”);
  }
})

Input = élément spécial => utiliser la fonction val.
Récupérer ET placer des informations.
jQuerry permet de déterminer un comportement css
———————————————

### Liens utiles

- [Mozilla Javascript Reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
- [API jQuery](http://www.api.jquerry.com)
- [Codeacademy Javascript](http://www.codecademy.com/en/tracks/javascript)



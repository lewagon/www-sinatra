---
layout: post
title: "JavaScript pour les débutants"
author: cedric
labels:
  - meetup
  - tuto
  - video
pushed: true
thumbnail: thumbnail-workshop-javascript.jpg
description: Gilles Manzato vous expose les bases de JavaScript avant de vous présenter la librairie jQuery et le principe des requêtes AJAX dans un tutoriel vidéo d'une heure. Des variables au callback, vous apprendrez quelques notions rapidement utilisables pour vos projets personnels du moment.
---

<div class="video-wrapper"><iframe width="750" height="422" src="//www.youtube.com/embed/G8OsHFT99os?showinfo=0" frameborder="0" allowfullscreen></iframe></div>

[Gilles Manzato](https://twitter.com/gillesm) vous expose les bases de JavaScript avant de vous présenter la librairie jQuery et le principe des requêtes AJAX dans un tutoriel vidéo d'une heure. Des variables au callback, vous apprendrez quelques notions rapidement utilisables pour vos projets personnels du moment.

### Un peu d'histoire

Le JavaScript, à ne pas confondre avec Java, est un langugage web créé en 1985 utilisé à la fois pour créer des pages web interactives (il s'interface avec le HTML et le CSS), mais également du côté serveur. Il y a encore 10 ans le JavaScript était encore peu utilisé, mais les récentes évolutions des navigateurs web ont boosté les performances de ce langage avec un gain de performance de l'ordre de 1 à 1000 depuis IE6 a Chrome. L'arrivée du framework jQuery, dont nous parlerons plus tard, a également favorisé son expansion.

### Le Setup

Pour suivre ce tutoriel vous aurez besoin du [navigateur Chrome](http://www.google.com/chrome/) installé afin d'utiliser la [console](https://developer.chrome.com/devtools/docs/console). Ouvrez également [jsFiddle](http://jsfiddle.net/) dans un onglet pour tester votre code rapidement.

Pour ouvrir la *console*, utilisez les raccourcis suivants :

- Sur Windows : Ctrl + Maj + J
- Sur Mac : ⌘ + ⌥ + I

**Important :** Pour des raisons de sécurité la console JS est isolée et liée à la durée de vie de la page. Au cours des exercices, ne rafraîchissez pas la page sous peine de tout devoir recommencer !

### Les bases

Ce résumé n'a pas pour objectif de retranscrire de manière exhaustive toutes les notions évoquées dans la vidéo ci-dessus, mais simplement de faciliter la mémorisation et/ou l'accès aux lignes de code utilisées pour les différents exercices.

**LES TYPES DE DONNÉES**

Il existe 3 grands types de données :

- Les nombres (*number*)
- Les strings (*string*): se sont des chaînes entre guillemets du type ```"Bonjour"```
- Les booléens (*boolean*) : true, false, 0 et 1. Ils sont utilisés pour valider ou invalider des conditions.

**LES OPÉRATEURS ARITHMÉTIQUES**

- Addition et/ou concaténation de string : + (1)
- Soustraction : -
- Multiplication : *
- Division : /
- Modulo : % (2)

(1) *Exemple de concaténation : ```"Ceci est une string " + "n'est-ce pas ?"``` vous retournera ```"Ceci est une string n'est-ce pas ?"```*
(2) *Le modulo vous donne le reste d'une division.*

**Les variables**

Pour stocker des informations dans une variable : ```var age = 8;```
Notez que ```age``` peut être remplacé par n'importe quelle chaîne de caractère selon votre convenance.

Pour récupérer votre variable, il suffit ensuite de la nommer dans la console afin de récupérer la donnée stockée.
Ainsi ```age``` vous retournera ```8```.

Si vous souhaitez changer la donnée associée à ```age```, il suffit d’écrire ```age = 15;``` sans repréciser le ```var```.

*Astuce* : Pour connaître le type d'une variable, rentrez dans votre console ```typeof(votre_variable)```

**IF, ELSE**

Les conditions permettent simplement de retourner un résultat A ou B en fonction de la condition énoncée. Dans l'exemple ci-dessous notre variable ```nombre``` est égale à ```10``` et sera donc supérieur à 5. Le code nous retournera donc ```plus grand que 5```. Notez que *if* n’est pas obligatoirement suivi d'un *else* et qu'il est possible de s’en servir seul afin de vérifier une condition qui nous renvera donc un boolean *true* ou *false*.

```js
var age = 10;
if(age >= 5){
  console.log('plus grand que 5')
}
else {
  console.log('plus petit que 5')
}
```

*Astuce :* ```console.log``` permet d’afficher le résultat de vos actions directement dans la console.

**LES FONCTIONS**

Une fonction est un morceau de code stocké dans une variable que l’on va pouvoir réutiliser plus tard afin de lui demander d’exécuter une action bien précise sur un *argument*.

```js
var greets = function(name){
  return "Bonjour " + name;
}
```

Ensuite, en passant l’argument ```Gilles``` à ```greet``` en suivant cette syntaxe ```greets(“Gilles”)``` la console vous retournera la string concaténée ```"Bonjour Gilles"```.


### Le jQuery

[jQuery](http://jquery.com/) est une bibliothèque JavaScript créée pour faciliter l'écriture de scripts afin d'animer les pages web. Le JavaScript utilise le DOM (la représentation du navigateur de l'arbre HTML) pour communiquer avec la page, mais celui-ci n'est malheureusement pas standardisé entre les navigateurs. jQuery synthétise tous ces éléments et propose une multitude de fonctions qui s’appuient sur les sélecteurs CSS.

**Important :** Le ```$``` permet d’accéder directement à l’objet jQuery.

**PREMIER EXEMPLE**

<iframe width="100%" height="150" src="http://jsfiddle.net/mecedric/jxfvcpx5/embedded/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>

Dans cet exemple, le navigateur commence par lire et interpréter le code HTML avant de remplacer le contenu de la ```div``` à l'id ```#greets`` (sélecteur css) par ```Bonjour``` modifiant ainsi le texte initial.

**LES ANIMATIONS**

En suivant la même logique que précédemment, il est très facile de créer des animations sur sa page web. L'exemple suivant vous montre comment afficher / effacer un texte d'un simple click grâce au [toggle()](http://api.jquery.com/?s=toggle).

<iframe width="100%" height="150" src="http://jsfiddle.net/mecedric/9Lagh4ne/embedded/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>

L'idée est d'affecter un événement ```on click``` au bouton comprenant la class css ```active``` afin de déclencher le toggle sur la balise ```<p>``` avec la classe css ```spoiler```.


C'est ici qu'intervient la notion de **Callback**. Il s'agit d'une fonction appelée lorsque l’utilisateur lance un événement (scrolling, click...)

Pour aller plus loin, sachez qu'il est possible d'enchaîner les actions les unes aux autres. Avec le code ci-dessous, le spoiler apparaîtra au click et bénéficiera d'une animation d'entrée qui réduira son opacité de moitié (0.5) en 1000 millisecondes soit 1 seconde.

```js
$(".active").on("click", function(){
  $(".spoiler").show().animate({opacity:0.5}, 1000);
})
```

### Les requêtes AJAX

L'AJAX vous donne la possibilité de faire des requêtes asynchrones vers des données externes (via une url pointant vers des données ouvertes d'une API) ou internes du site sans jamais recharger la page. La plupart du temps, les données arriveront sous forme de JSON : un objet JavaScript facile à accéder sans aucun impact sur les performances.

**RÉCUPÉRER DES DONNÉES JSON**

Pour l'exemple suivant, nous effectuerons une requête auprès de l'API de Facebook afin de récupérer les données publiques de son célèbre fondateur : ```http://graph.facebook.com/4```

```html
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
```

Via cette url, les informations ci-dessus vont être lues et parsées par notre code jQuery. Lorsque la requête est effectuée la fonction [.success(function(data){ ...})](http://api.jquery.com/ajaxSuccess/) se lance afin de lancer la concaténation du prénom et du nom de famille (en prenant soin de les séparer par un espace) et de la faire apparaître en ```HTML``` dans notre balise ```<p>```.

<iframe width="100%" height="150" src="http://jsfiddle.net/mecedric/u9bbhnjy/embedded/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>

**RÉCUPÉRER DES DONNÉES JSON DE PLUSIEURS IDs**

Il s'agit ici de suivre exactement le même procédé que celui énoncé précédemment en prenant le soin d'y inclure deux petites nuances. L'url retournée par l'API de Facebook sera composée de plusieurs IDs : http://graph.facebook.com/**?ids=4,5,6**

Afin de parcourir l'ensemble des IDs retournées par l'API, il va falloir lancer la fonction [.each](http://api.jquery.com/each/) afin d'appliquer une fonction à chacun des éléments présents dans l'index du fichier JSON retourné : ```$.each(data, function(index, item){ ... }```

Au sein de cette dernière fonction, la fonction [.append()](http://api.jquery.com/append/) va permettre d'ajouter du contenu à chacune des itérations entraînées par **.each**.

<iframe width="100%" height="150" src="http://jsfiddle.net/mecedric/zohL7t78/embedded/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>

**VALIDATION DE FORMULAIRE**

Après avoir créé les bases d'un formulaire comprenant un input destiné à stocker une adresse mail et un bouton de validation, nous allons coder une fonction pour confirmer le remplissage d'un champ.

Grâce à un simple If, Else, nous allons écouter notre input pour savoir si celui-ci est vide ```if($(".email").val() == "") { ... }``` ou plein ```else { ... }``` afin de faire apparaître un text ```vide``` ou ```valide```.

```$(".email").css("border", "1px solid red");``` permet d'injecter du css sur la classe ```.email```de notre input afin de changer la bordure de couleur si le champ est resté vide.

<iframe width="100%" height="180" src="http://jsfiddle.net/mecedric/wo6e4dsb/embedded/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>


### Liens utiles

- [Mozilla JavaScript Reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
- [API jQuery](http://www.api.jquerry.com)
- [Codeacademy Javascript](http://www.codecademy.com/en/tracks/javascript)

###Reminder

Ne ratez plus un seul de nos événements Tech et rejoignez [la communauté Meetup du Wagon](http://www.meetup.com/Le-Wagon-Paris-Coding-Station/)
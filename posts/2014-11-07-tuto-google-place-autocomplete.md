---
layout: post
label: startup
title: Google Place Autocomplete
thumbnail: thumbnail-google-autocomplete.jpg
author: cedric
labels:
  - tuto
pushed: true
description: Apprenez rapidement à installer Google Place Autocomplete dans vos formulaires comportant une adresse. Ces quelques lignes de code faciliteront grandement l'expérience de vos utilisateurs sur votre site. À vous de jouer !
---

Apprenez rapidement à installer Google Place Autocomplete dans vos formulaires comportant un champ adresse. Ces quelques lignes de code faciliteront grandement l'expérience de vos utilisateurs sur votre site. À vous de jouer !

![Tutorial, Google Place Autocomplete](blog_image_path tuto-google-place-autocomplete.gif)

**Disclaimer** Pour les codeurs / intégrateurs / dev de tous poils, jetez directement un oeil à la documentation de [@ssaunier](https://twitter.com/ssaunier) sur [le repo github](https://github.com/lewagon/google-place-autocomplete). Pour les autres, nous détaillerons l'ensemble de la procédure et expliciterons dans les quelques lignes ci-dessous.

### La logique

Le champ dans lequel l'utilisateur tape son adresse retourne une liste d'adresses possibles en fonction des quelques caractères déjà écrits. Lorsque l'adresse souhaitée est sélectionnée, les données la composant (rue, numéro de voie ...) sont parsées et injectées dans les champs de la base de données de votre service.

[Voir la démo](http://lewagon.github.io/google-place-autocomplete/)

### API Key Google Map

Dernière étape du setup, récupérez une clé API de Google Map afin d'obtenir un pool de 25.000 requêtes API gratuites par jour. Pour cela, rendez-vous sur [Google API Console](https://code.google.com/apis/console) et activez Google Maps JavaScript API v3.

![Tutorial, Google Place API](blog_image_path tuto-google-place-autocomplete-api.jpg)

Dans le menu APIs & auth, cliquez sur l'onglet Credentials et activez votre Public API access sans oublier de préciser la liste des domaines autorisés à effectuer des requêtes (n'oubliez pas que votre quota est limité !).

![Tutorial, Google Maps API Key](blog_image_path tuto-google-place-autocomplete-api-key.jpg)

Enfin, appellez l'API de Google Maps dans votre ficher HTML en insérant votre clé à la fin en suivant l'exemple ci-dessous.


```html
<!-- Include Google Maps JS API -->
<script type="text/javascript"
  src="https://maps.googleapis.com/maps/api/js?libraries=places&key=PUT_YOUR_OWN_KEY_HERE">
</script>

<!-- Custom JS code to bind to Autocomplete API -->
<!-- find it here: https://github.com/lewagon/google-place-autocomplete/blob/gh-pages/autocomplete.js -->
<!-- We'll detail this file in the article -->
<script type="text/javascript" src="autocomplete.js"></script>
```

### Le formulaire HTML

Pour notre exemple nous utiliserons un formulaire composé de 5 champs. Le premier, *Address*, sera accessible à l'utilisateur afin de lui permettre de saisir son adresse postale. Les 4 autres champs ; `street_number`, `route`, `locality` et `country` seront désactivés et ne serviront qu'à recueillir la donnée.

```html
<form>
  <label>Address</label>
  <input id="user_input_autocomplete_address" placeholder="Votre adresse...">
  <label>street_number</label>
  <input id="street_number" name="street_number" disabled>
  <label>route</label>
  <input id="route" name="route" disabled>
  <label>locality</label>
  <input id="locality" name="locality" disabled>
  <label>country</label>
  <input id="country" name="country" disabled>
</form>
```

### La recherche

```js
function initializeAutocomplete(id) {
  var element = document.getElementById(id);
  if (element) {
    var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
  }
}
```

```html
<input id="user_input_autocomplete_address" placeholder="Start typing your address...">
```

La méthode ```initializeAutocomplete``` prend l'id de l'input sur lequel se greffer (soit dans notre cas ```user_input_autocomplete_address```), crée un autocomplete, et écoute l'événement ```place_changed```. Lorsque cet évènement a lieu (c'est à dire lorsque l'utilisateur choisit une adresse), alors la fonction de callback ```onPlaceChanged``` est appelée. C'est dans cette dernière que nous allons récupérer les informations détaillées de l'adresse choisie

### La récupération des données

```js
function onPlaceChanged() {
  var place = this.getPlace();

  // console.log(place);  // Uncomment this line to view the full object returned by Google API.

  for (var i in place.address_components) {
    var component = place.address_components[i];
    for (var j in component.types) {  // Some types are ["country", "political"]
      var type_element = document.getElementById(component.types[j]);
      if (type_element) {
        type_element.value = component.long_name;
      }
    }
  }
}
```

À partir de ce point, les informations sont découpées et son dispatchées dans un tableau avec un système clés/valeurs.

```json
{
  "address_components": [
    { "long_name": "25",            "types": [ "street_number" ] },
    { "long_name": "Petit Musc St", "types": [ "route" ] },
    { "long_name": "Paris",         "types": [ "locality", "political" ] }
    // [...]
  ]
}
```

**Important** Comme le montre l'extrait du JSON ci-dessus retourné par l'API de Google Maps sur la console, il est impératif de respecter la dénomination des inputs de votre formulaire ```HTML``` selon un système clés/valeurs bien précis.

```html
<form>
  <input id="street_number" name="street_number" disabled>
  <input id="route"         name="route"         disabled>
  <input id="locality"      name="locality"      disabled>
  <input id="country"       name="country"       disabled>
</form>
```

Dans la vie réelle, il suffira de passer ces `input` en `type="hidden"` pour qu'ils soient soumis à
l'envoi du formulaire. Vous récupérerez ainsi l'adresse prédécoupée correctement.

### Exécuter le code

Afin de démarrer le code il est nécessaire d'exécuter ```initializeAutocomplete``` lorsque Google est disponible et que la page est prête.

```js
google.maps.event.addDomListener(window, 'load', function() {
  initializeAutocomplete('user_input_autocomplete_address');
});
```

### Pour aller plus loin

Il est possible de customiser votre Autocomplete et de restreindre les recherches à une zone géographie précise voir à un type exclusif de lieux (villes, business...).

Par exemple, grâce snippet ci-dessous, nous limitons les résultats aux business (``` types: ['establishment']```) situés à Paris et Londres en déterminant leurs latitudes et longitudes respectives dans la variable ```defaultBounds```. Pour en savoir plus, rendez-vous [ici](https://developers.google.com/maps/documentation/javascript/places-autocomplete).

```js
var defaultBounds = new google.maps.LatLngBounds(
  new google.maps.LatLng(48.856614, 2.3522219000000177),
  new google.maps.LatLng(51.5073509, -0.12775829999998223));

var input = document.getElementById('searchTextField');
var options = {
  bounds: defaultBounds,
  types: ['establishment']
};

autocomplete = new google.maps.places.Autocomplete(input, options);
```

N'hésitez pas à laisser vos propres trucs et astuces dans les commentaires de cet article !

### Liens utiles

- [lewagon/google-place-autocomplete sur GitHub](https://github.com/lewagon/google-place-autocomplete)
- [Démo](http://lewagon.github.io/google-place-autocomplete/)
- [Google Autocomplete documentation](https://developers.google.com/maps/documentation/javascript/places-autocomplete)
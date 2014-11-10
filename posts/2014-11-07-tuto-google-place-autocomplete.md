---
layout: post
title: Google Place Autocomplete
thumbnail: thumbnail-google-autocomplete.jpg
author: cedric
description:
---

*Ce tuto à pour objectif de vous guider pas à pas dans l'installation d'un Google Place Autocomplete dans vos formulaires d'adresses. Ces quelques lignes de code faciliteront grandement l'expérience de vos utilisateurs tout en prenant soin de parser chacun des éléments afin de l'insérer dans votre base de données.*

![Tutorial, Google Place Autocomplete](blog_image_path tuto-google-place-autocomplete.gif)

**disclaimer** Pour les codeurs / intégrateurs / dev de tous poils, jetez directement un oeil à la documentation de [Seb Saunier](https://twitter.com/ssaunier) sur [le repo Github du Wagon](https://github.com/lewagon/google-place-autocomplete). Pour les autres, nous détaillerons l'ensemble de la procédure et expliciterons dans les quelques lignes ci-dessous.

### La logique

Le champ dans lequel l'utilisateur tape son adresse renvoie les possibilités d'adresses connues/retourne une liste d'adresses possibles en fonction des quelques caractères déjà écrits. Lorsque l'adresse souhaitée est sélectionnée, les données la composant (rue, numéro de voie ...) sont parsées et injectées dans les champs de la base de données de votre service.

[Voir la démo](http://lewagon.github.io/google-place-autocomplete/)

### Le formulaire HTML

Pour notre exemple nous utiliserons un formulaire composé de 5 champs. Le premier, *Address*, sera accessible à l'utilisateur afin de lui permettre de saisir son adresse postale. Les 4 autres champs ; `street_number`, `route`, `locality` et `country` seront désactivés et ne serviront qu'à recueillir la donnée.

```html
<form>
  <label>Address</label>
  <input id="user_input_autocomplete_address" name="user_input_autocomplete_address" placeholder="Votre adresse...">
  <label>street_number</label>
  <input id="street_number" name="street_number" disabled="true">
  <label>route</label>
  <input id="route" name="route" disabled="true">
  <label>locality</label>
  <input id="locality" name="locality" disabled="true">
  <label>country</label>
  <input id="country" name="country" disabled="true">
</form>
```

#### Autocomplete.js

Créez un nouveau fichier `autocomplete.js` et insérez le code JS disponible [ici](https://github.com/lewagon/google-place-autocomplete/blob/gh-pages/autocomplete.js) avant de l'appeller dans votre fichier `HTML`.

```html
  <!-- Custom JS code to bind to Autocomplete API -->
  <script type="text/javascript" src="autocomplete.js"></script>
```

### API Key Google Map

Dernière étape du setup, récupérer une clé API de Google Map afin d'obtenir un pool de 25.000 requêtes API gratuites par jour. Pour cela, rendez-vous sur [Google API Console](https://code.google.com/apis/console) et activez Google Maps JavaScript API v3.

![Tutorial, Google Place API](blog_image_path tuto-google-place-autocomplete-api.jpg)

Dans le menu APIs & auth, cliquez sur l'onglet Credentials et activez votre Public API access sans oublier de préciser la liste des domaines autorisés à effectuer des requêtes (n'oubliez pas que votre quota est limité !).

![Tutorial, Google Maps API Key](blog_image_path tuto-google-place-autocomplete-api-key.jpg)

Enfin, appellez l'API de Google Maps dans votre ficher HTML en insérant votre clé à la fin en suivant l'exemple ci-dessous.


```html
  <!-- Include Google Maps JS API -->
  <script type="text/javascript"
    src="https://maps.googleapis.com/maps/api/js?libraries=places&amp;key=AIzaSyDiLbha2ADV-c4IjStjSFCj01FcwrOhteI">
  </script>
```

### La recherche


```js
function initializeAutocomplete(id) {
    var element = document.getElementById(id);
    var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
  }
```

```html
 <input id="user_input_autocomplete_address" name="user_input_autocomplete_address" placeholder="Start typing your address...">
 ```

La méthode ```initializeAutocomplete``` prend l'id de l'input sur lequel se greffer (soit dans notre cas ```user_input_autocomplete_address```), crée un autocomplete, et ajoute un listener via le callback de l'événement ```place_changed``` permettant de capturer le lieu que l'utilisateur a choisi parmi ceux auto-suggérés.

### La récupération des données

```js
for (var i in place.address_components) {
  var component = place.address_components[i];
  for (var j in component.types) {  // Some types are ["country", "political"]
    var type_element = document.getElementById(component.types[j]);
    if (type_element) {
      type_element.value = component.long_name;
    }
  }
}
```

À partir de ce point, les informations sont découpées et son dispatchées dans un tableau avec un système clés/valeurs.

```html
Adresse_component {
  25[street_number],
  rue du petit musc[route],
  Île de France[admnistrative_area_level_1],
  ...
}
```

**Important** Comme le montre l'extrait du JSON ci-dessous retourné par l'API de Google Maps sur la console, il est impératif de respecter la dénomination des inputs de votre formulaire ```HTML``` selon un système clés/valeurs bien précis.

```html
  address_components: Array[7]
    0: Object
      long_name: "25"
      short_name: "25"
      types: Array[1]
        0: "street_number" <!-- Input numéro de la rue -->
    1: Object
      long_name: "Petit Musc St"
      short_name: "Petit Musc St"
      types: Array[1]
        0: "route" <!-- Input nom de la rue -->
    2: Object
      long_name: "Paris"
      short_name: "Paris"
      types: Array[2]
        0: "locality" <!-- Input nom de la ville -->
        1: "political"
    4: Object
      long_name: "France"
      short_name: "France"
      types: Array[2]
        0: "country" <!-- Input nom du pays -->
        1: "political"
    ...
```

Ce qui se traduit dans votre fichier ```HTML``` par :

```html
  <form>
    <input id="street_number" name="street_number" disabled="true">
    <input id="route" name="route" disabled="true">
    <input id="locality" name="locality" disabled="true">
    <input id="country" name="country" disabled="true">
  </form>
```

### Exécuter le code

Afin de démarrer le code, et comme celui-ci n'a pas de dépendance à jQuery, il est nécessaire d'exécuter ```initializeAutocomplete``` lorsque Google est disponible et que la page est prête.

```js
  google.maps.event.addDomListener(window, 'load', function() {
    initializeAutocomplete('user_input_autocomplete_address');
  });
```

### Pour aller plus loin

Il est possible de customiser votre Autocomplete et de restreindre les recherches à une zone géographie précise voir à un type exclusif de lieux (villes, business...).

Par exemple, grâce snippet ci-dessous, nous limitons les résultats aux business (``` types: ['establishment']```) situés sur Paris et Londres en déterminant leurs latitudes et longitudes respectives dans la variable ```defaultBounds```. Pour en savoir plus, rendez-vous [ici](https://developers.google.com/maps/documentation/javascript/places-autocomplete).

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

- [Repository Github du Wagon](https://github.com/lewagon/google-place-autocomplete)
- [Démo](http://lewagon.github.io/google-place-autocomplete/)
- [Google Autocomplete documentation](https://developers.google.com/maps/documentation/javascript/places-autocomplete)



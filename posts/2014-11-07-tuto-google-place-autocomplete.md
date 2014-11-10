---
layout: post
title: Google Place Autocomplete
thumbnail: thumbnail-google-autocomplete.jpg
author: cedric
description:
---

*Ce tuto à pour objectif de vous guider pas à pas dans l'installation d'un Google Place Autocomplete dans vos formulaire d'adresse. Ces quelques lignes de code faciliteront grandement l'éxpérience de vos utilisateurs tout en prenant soin de parser chacun des élements afin de l'insérer dans votre base de donnée.*

![Tutorial, Google Place Autocomplete](blog_image_path tuto-google-place-autocomplete.jpg)

**disclaimer** Pour les codeurs / intégrateurs / dev de tous poil, jetez directement un oeil à la documentation de [Seb Saunier](https://twitter.com/ssaunier) sur [le repo Github du Wagon](https://github.com/lewagon/google-place-autocomplete). Pour les autres, nous détaillerons l'ensemble de la procédure et expliciterons dans les quelques lignes ci-dessous.

### La logique

Le champ dans lequel l'utilisateur rentre son adresse envoi une requête asynchrone à l'API de Google qui de son côté renvoi les possibilités d'adresse connues. Lorsque l'utilisateur sélectionne la bonne adresse, les données la composant (rue, numéro de voie...) sont parsés et injectées dans les champs de la base de donnée de votre service.

[Voir la démo](http://lewagon.github.io/google-place-autocomplete/)

### Le formulaire HTML

Pour notre exemple nous utiliserons un formulaire composé de 7 champs. Le premier, *Address*, sera accessible à l'utilisateur afin de lui permettre de saisir son adresse postale. Les 6 autres champs (`street_number`, `route`, `locality`, `administrative_level_1`, `postal_code`, `country`) seront désactivés et ne serviront qu'à recueillir la donnée.

L'input Address doit absolument avoir l'id `user_input_autocomplete_address` car ils s'agit là du lien avec le code JS qui nous verrons par la suite.

```html
<form>
    <label>Address</label>
    <input id="user_input_autocomplete_address" name="user_input_autocomplete_address" placeholder="Start typing your address...">

    <label>street_number</label>
    <input id="street_number" name="street_number" disabled="true">
    <label>...</label>
    <input id="..." name="..." disabled="true">
</form>
```

#### Autocomplete.js

Créez un nouveau fichier `autocomplete.js` et copiez-collez le code ci-dessous.

```js
  function initializeAutocomplete(id) {
    var element = document.getElementById(id);
    var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
  }

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

  google.maps.event.addDomListener(window, 'load', function() {
    initializeAutocomplete('user_input_autocomplete_address');
  });
```


N'oubliez pas de l'appeller ensuite dans votre fichier `HTML`

```html
  <!-- Custom JS code to bind to Autocomplete API -->
  <script type="text/javascript" src="autocomplete.js"></script>
```

### API Key Google Map

Dernière étape du setup, récupérer une clé API de Google Map afin d'obtenir un pool de 25.000 requête API gratuites par jour. Pour cela, rendez-vous sur [Google API Console](https://code.google.com/apis/console) et activez Google Maps JavaScript API v3.

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

### Mais que se passe t-il dans le code ?


```js
function initializeAutocomplete(id) {
    var element = document.getElementById(id);
    var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
  }
```

Dans votre fichier HTML, l'input Address doit absolument avoir pour ID ```user_input_autocomplete_address"``` afin d'initialiser la fonction javascript.

```html
 <input id="user_input_autocomplete_address" name="user_input_autocomplete_address" placeholder="Start typing your address...">
 ```

```js
var element = document.getElementById(id);
```

Cela va permettre à Google de vous retourner un hash contenant les élements d'une adresse (rue, code postale...)

```js
var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });
```

Quelque soit les données que vous tapez à la volée.

```js
google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
```

Le deuxième block permet ensuite, d'envoyer chacun des morceaux de l'adresse ```place.address_components``` dans un array ```[i]```, lui même contenant un array ```[j]``` précisant le type de l'objet ```component.types``` avec pour clé ```long.name```.

Exemple :

```html
Adresse_component {
  25[street_number],
  rue du petit musc[route],
  Île de France[admnistrative_area_level_1],
  ...
}
```

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

**Important** Comme le montre la capture d'écran ci-dessous, il est impératif de respecter la dénomination des inputs de votre formulaire ```HTML``` selon le système clés/valeurs établi par l'API de Google Map.

Ex : La région doit avoir pour id ```administrative_area_level_1```

```html
<input id="administrative_area_level_1" name="administrative_area_level_1" disabled="true">
```

![Tutorial, Google Place Objects](blog_image_path tuto-google-place-autocomplete-objects.jpg)

Enfin, ce code est indépendant de jQuery. Il vous faudra donc appeler la méthode ```initializeAutocomplete``` suite au chargement du DOM.

```js
google.maps.event.addDomListener(window, 'load', function() {
    initializeAutocomplete('user_input_autocomplete_address');
  });
```

### Liens utiles

- [Repository Github du Wagon](https://github.com/lewagon/google-place-autocomplete)
- [Démo](http://lewagon.github.io/google-place-autocomplete/)
- [Google Autocomplete documentation](https://developers.google.com/maps/documentation/javascript/places-autocomplete)



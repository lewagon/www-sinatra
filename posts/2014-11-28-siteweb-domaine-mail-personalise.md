---
layout: post
title: "Personnalisez l'url de votre site"
author: cedric
labels:
  - tuto
pushed: true
thumbnail: thumbnail-tuto-url-custom.jpg
description: "Après avoir publié votre premier site web via GitHub Pages, nous vous proposons maintenant d'apprendre à personnaliser votre nom de domaine ainsi que votre adresse mail de contact."
---

Après avoir publié [votre premier site web via GitHub Pages](http://www.lewagon.org/blog/publier-site-github-pages) il vous faut désormais personnaliser votre nom de domaine afin d'obtenir une url de la forme ```http://www.votreprojet.com```. Afin de mieux comprendre les différentes étapes, nous verrons comment fonctionne votre navigateur web avant de se diriger vers OVH pour l'achat de votre nom de domaine et enfin nous le configurerons pour GitHub Pages.

### Comment fonctionne votre navigateur web ?

DNS (*Domain Name System*), adresse IP, hébergement... Derrière ce vocabulaire un brin barbare se cachent les principaux engrenages utiles au bon fonctionnement de votre navigateur web. Cet excellent petit comic de [Vladstudio](http://www.vladstudio.com/wallpaper/?how_internet_works) permet de mieux comprendre ce qui se passe à chaque fois que vous saisissez votre url favorite.

![How your web browser works](blog_image_path tuto-how-web-browser-works.jpg)

Vous voyez que le DNS joue le rôle d'annuaire, en convertissant un nom de domaine (`www.google.com`) en une adresse IP (`23.45.67.89`). La raison de l'existence d'un tel système est que nous autres humains pouvons facilement retenir et lire un nom de domaine, alors que retenir des numéros (ceux d'une adresse IP) est plus fastidieux. D'ailleurs, lorsque nous utilisons nos téléphones portables, nous ne composons plus de numéro, mais nous cherchons la personne à appeler dans nos contacts (l'annuaire *local* du téléphone).

### Une nouvelle url ? Mais je possède déjà une url GitHub non ?

Effectivement, une adresse IP est déjà rattachée à votre url GitHub Pages. Elle prend la forme `http://VOTRE_NOM_GITHUB.github.io/votreprojet`. Une fois votre nouveau nom de domaine associé à l'adresse IP de votre site celui-ci agira comme un *alias* sur l'url fournie par GitHub Pages. Ainsi lorsqu'un nagivateur soumettra la requête ```www.votreprojet.com```, le serveur DNS lui indiquera l'IP de ```VOTRE_NOM_GITHUB.github.io```.

### L'achat de votre nom de domaine

**Étape 1 :** Rendez-vous sur [ovh.com](https://www.ovh.com/fr/index.xml) et commencez par vérifier la disponibilité du nom de domaine souhaité.

![Choix du nom de domaine](blog_image_path tuto-nom-domaine-1.jpg)

Cliquez sur **commander** et suivez le parcours d'achat :

**Étape 2 :** Suivez le parcours d'achat puis choisissez l'option **DNS Classique (gratuit)** ainsi que l'offre **Gold**

![DNS et offre Gold](blog_image_path tuto-nom-domaine-2.jpg)

**Étape 3 :** Ne prenez aucun hébergement avec ce nom de domaine. GitHub Pages vous offre déjà ce service gratuitement !

![DNS et offre Gold](blog_image_path tuto-nom-domaine-3.jpg)

**Étape 4 :** Si ce n'est pas déjà fait, créez-vous un compte OVH. Pour des raisons juridiques, il est impératif de déclarer son identité lors de l'achat d'un nom de domaine.

**Étape 5 :** Lors du choix des serveurs DNS conservez les serveurs OVH par défaut.

![Conservez les DNS d'origines](blog_image_path tuto-nom-domaine-4.jpg)

**Étape 6 :** Acceptez les conditions générales et cochez la case vous notifiant de votre droit de rétractation.

**Étape 7 :** Payez par le moyen de votre choix (si certains d'entre vous souhaitent payer par chèque ou virement, sachez que votre nom de domaine ne sera pas actif avant la confirmation du paiement par OVH.)

Une fois le paiement terminé, attendez quelques minutes avant de recevoir votre facture et le mail d'avertissement vous prévenant de l'activation de votre nom de domaine et de sa disponibilité dans l'interface client d'OVH.

### Configurez votre nouveau nom de domaine du côté OVH

En premier lieu, rendez-vous sur le [Manager OVH](https://www.ovh.com/manager/web/login/). Connectez-vous avec votre identifiant et mot de passe.

Cliquez ensuite sur votre nouveau **nom de domaine** dans la colonne de gauche, puis sur l'onglet **DNS Zone**.

![Configuration des DNS - étape 1](blog_image_path tuto-dns-1.jpg)

Dans la liste, cherchez l'entrée ```www.votreprojet.com.``` de type **CNAME** et cliquez sur l'icône afin de l'éditer.

![Configuration des DNS - étape 2](blog_image_path tuto-dns-2.jpg)

Dans le formulaire suivant :

- Laissez le champ **Sub-domain** avec ```www```
- Dans le menu déroulant, sélectionnez TTL par défaut
- Changez le champ **Target** pour le faire pointer vers l'adresse de votre repository Github : ```VOTRE_NOM_GITHUB.github.io.```

**important*** Le ```.``` à la fin est fondamental. **Ne l'oubliez pas !**

![Configuration des DNS - étape 3](blog_image_path tuto-dns-3.jpg)

### Configurez votre nouveau nom de domaine sur votre site

Dans un second temps, ouvrez Sublime Text ou n'importe quel autre éditeur de texte de votre choix et créez un fichier ```CNAME``` à la racine de votre projet écrivez le domaine (`www.votreprojet.com`).

Sauvegardez puis retournez sur l'application GitHub for Mac. Le fichier `CNAME` devrait être visible dans la zone dédiée aux changements effectués localement. Commitez puis synchronisez. Afin de vérifier que le fichier a bien été envoyé, n'hésitez pas à jeter un oeil sur votre *repository* en ligne. La mise à jour s'effectue généralement dans un délai de une seconde à dix minutes.

![Configuration du CNAME](blog_image_path tuto-configuration-cname.jpg)

Vous n'avez plus qu'à attendre une bonne heure que tous ces changements soient pris en compte. Rafraîchissez ensuite la page de votre navigateur pointant vers votre nouvelle url afin de vérifier que tout fonctionne. Félicitations, votre site est hébergé et bénéficie désormais de son propre nom de domaine !

### Votre adresse contact@nomdedomaine.fr

La deuxième partie de ce tuto concerne la redirection d'une adresse mail *contact@nomdedomaine.fr* vers votre adresse mail personnelle ce qui aura pour principal avantage de centraliser tous vos messages en un seul et même endroit. Si vous souhaitez ensuite effectuer une segmentation des messages, rien ne vous empêche de regarder du côté [des filtres de votre client mail préféré](https://support.google.com/mail/answer/6579?hl=fr).

De la même manière que pour configurer vos DNS, retournez sur le [Manager OVH](https://www.ovh.com/manager/web/login/), sélectionnez votre **nom de domaine** dans la colonne de gauche et cliquez ensuite sur l'onglet **Emails** puis **Manage redirections**.

![Configuration d'un mail perso - étape 1](blog_image_path tuto-mail-configuration.jpg)

Ajoutez une redirection et remplissez le formulaire en précisant dans le premier champ l'adresse que vous souhaitez créer (ex : contact@votrenomdedomaine.fr) puis dans le deuxième champ, l'adresse vers laquelle vous souhaitez voir les messages redirigés (ex : votremailperso@gmail.com). Pour information, vous pouvez créer autant de redirections que vous le souhaitez (très utile si vous êtes plusieurs à travailler sur un projet).

![Configuration d'un mail perso - étape 2](blog_image_path tuto-mail-configuration-2.jpg)

Attendez quelques minutes afin que ces derniers changements soient pris en compte et faites un test en vous envoyant un mail à contact@votrenomdedomaine.fr - si vous avez respecté toutes les étapes ci-dessus alors vous devriez recevoir le message dans votre boîte mail en quelques secondes.

Dans un prochain tuto, nous verrons comment intégrer très simplement un formulaire de contact sur votre site. Pour ceux qui souhaiteraient prendre un peu d'avance, n'hésitez pas à jeter un oeil sur [Form Keep](https://formkeep.com/) ou [Wufoo](http://www.wufoo.com).

### Liens utiles

- [OVH](https://www.ovh.com/fr/index.xml)
- [OVH Manager](https://www.ovh.com/manager/web/login/)

NB : Le Wagon n'est en aucun cas affilié à OVH et une alternative telle que [Gandi](http://www.gandi.net/) est tout aussi efficace !

---
layout: post
title: "Personnalisez l'url de votre site"
author: cedric
labels:
  - tuto
thumbnail: thumbnail-tuto-url-custom.jpg
description: "Après avoir publié votre premier site web via GitHub Pages, nous vous proposons maintenant d'apprendre à personnaliser votre nom de domaine ainsi que votre adresse mail de contact."
---

Après avoir publié votre premier site web via GitHub Pages il vous fait désormais personnaliser votre nom de domaine afin d'obtenir une url de la forme ```www.votreprojet.com```. Afin de mieux comprendre les différentes étapes, nous verrons comment fonctionne votre navigateur web avant de se diriger vers OVH pour l'achat de votre nom de domaine et enfin de configurer l'ensemble.

### Comment fonctionne votre navigateur web ?

DNS (*Domain Name System*), Adresse IP, hosting server... Derrière ce vocabulaire un brin barbare se cachent les principaux engrenages utiles au bon fonctionnement de votre navigateur web. Cet excellent petit comic de [Vladstudio](http://www.vladstudio.com/wallpaper/?how_internet_works) permet de mieux comprendre ce qui se passe à chaque fois que vous saisissez votre url favorite.

![How your web browser works](blog_image_path tuto-how-web-browser-works.jpg)

### Une nouvelle url ? Mais je possède déjà une url GitHub non ?

Effectivement, une adresse IP est déjà ratachée à votre url GitHub. Une fois votre nouveau nom de domaine associé à l'adresse IP de votre site celui-ci agira comme une sorte de *masque* sur l'url GitHub Pages. Ainsi lorsque qu'un nagivateur soumettra la requête ```www.votreprojet.com```, le serveur DNS lui indiquera l'IP de ```http://github.com/VOTRE_NOM_GITHUB/VOTRE_PROJET``` caché derrière ```www.votreprojet.com```.

### L'achat de votre nom de domaine

> **Étape 1 :** Rendez-vous sur [ovh.com](https://www.ovh.com/fr/index.xml) et commencez par vérifier la disponibilité du nom de domaine souhaité.

![Choix du nom de domaine](blog_image_path tuto-nom-domaine-1.jpg)

Cliquez sur **commander** et suivez le parcours d'achat :

> **Étape 2 :** Suivez le parcours d'achat puis choisissez l'option **DNS Classique (gratuit)** ainsi que l'offre **Gold**

![DNS et offre Gold](blog_image_path tuto-nom-domaine-2.jpg)

> **Étape 3 :** Ne prenez aucun hébergement avec ce nom de domaine. GitHub Pages vous offre déjà ce service gratuitement !

![DNS et offre Gold](blog_image_path tuto-nom-domaine-3.jpg)

> **Étape 4 :** Si ce n'est pas déjà fait, créez-vous un compte OVH. Pour des raisons juridiques il est impératif de déclarer son identité lors de l'achat d'un nom de domaine.

> **Étape 5 :** Lors du choix des serveurs DNS conservez les serveurs OVH par défault.

![Conservez les DNS d'origines](blog_image_path tuto-nom-domaine-4.jpg)

> **Étape 6 :** Acceptez les conditions générales et cochez la case vous notifiant de votre droit de rétractation.

> **Étape 7 :** Payez par le moyen de votre choix (si certains d'entre vous souhaitent payer par chèque ou virement, sachez que votre nom de domaine ne sera pas actif avant la confirmation du paiement par OVH.)

Une fois le paiement terminé, attendez quelques minutes avant de recevoir votre facture et le mail d'avertissement vous prévenant de l'activation de votre nom de domaine et de sa disponibilité dans l'interface client d'OVH.

### Configurez votre nouveau nom de domaine du côté OVH

En premier lieu, rendez-vous sur le [Manager OVH](https://www.ovh.com/manager/web/login/). Connectez-vous grace à votre identifiant et mot de passe.

Cliquez ensuite sur votre nouveau **nom de domaine** dans la colonne de gauche, puis sur l'onglet **Zone DNS**. Dirigez-vous ensuite sur le bouton **Ajouter une entrée**.

![Configuration des DNS - étape 1](blog_image_path tuto-dns-1.jpg)

Sélectionnez un type de champs de pointage ```CNAME```

![Configuration des DNS - étape 2](blog_image_path tuto-dns-2.jpg)

Dans le formulaire suivant :
- Remplissez le champs Sous-domaine avec ```www```
- Sélectionnez TTL par défaut
- La cible doit pointer vers l'adresse de votre repository Github : ```<votre_username_github>.github.io.```

**important*** Le ```.``` à la fin est fondamental. **Ne l'oubliez pas !**

![Configuration des DNS - étape 3](blog_image_path tuto-dns-3.jpg)

### Configurez votre nouveau nom de domaine sur votre site

Dans un second temps, ouvrez Sublime Text ou n'importe quel autre éditeur de texte de votre choix et créez un dossier ```CNAME``` à la racine de votre projet puis écrivez le nom de domaine que vous avez choisi sur la première ligne.

Sauvegardez puis retournez sur l'application GitHub for Mac. Le fichier CNAME devrait être visible dans la zone dédiée aux changements éffectués localement. Commitez puis synchronisez. Afin de vérifier que le fichier est bien été envoyé, n'hésitez pas à jeter un oeil sur votre *repository* en ligne.

![Configuration du CNAME](blog_image_path tuto-configuration-cname.jpg)

Vous n'avez plus qu'à attendre que tous ces changements soient pris en compte. Rafraîchissez ensuite la page de votre navigateur pointant vers votre nouvelle url afin de vérifier que tout fonctionne ! Félicitations, votre site est hébergé et bénéficie désormais de son propore nom de domaine !

### Votre adresse contact@nomdedomaine.fr

La deuxième partie de ce tuto concerne la redirection d'une adresse mail *contact@nomdedomaine.fr* vers votre adresse mail personnelle ce qui aura pour principal avantage de centraliser tous vos messages en un seul et même endroit. Si vous souhaitez ensuite effectuer une segmentation des messages, rien ne vous empêche de regarder du côté [des filtres de votre client mail préféré](https://support.google.com/mail/answer/6579?hl=fr).

De la même manière que pour configurer vos DNS, retournez sur le [Manager OVH](https://www.ovh.com/manager/web/login/), sélectionnez votre **nom de domaine** dans la colonne de gauche et cliquez ensuite sur l'onglet **Emails** puis **Gestion des Redirections**.

![Configuration d'un mail perso - étape 1](blog_image_path tuto-mail-configuration.jpg)

Ajoutez une redirection et remplissez le formulaire en précisant dans le premier champs l'adresse que vous souhaitez créer (ex : contact@votrenomdedomaine.fr) puis dans le deuxième champs, l'adresse vers laquelle vous souhaitez voir les messages redirigés (ex : votremailperso@gmail.com). Pour information, vous pouvez créer autant de redirections que vous le souhaitez (très utile si vous êtes plusieurs à travailler sur un projet).

![Configuration d'un mail perso - étape 2](blog_image_path tuto-mail-configuration-2.jpg)

Attendez quelques minutes afin que ces derniers changements soient pris en compte et faite un teste en vous envoyant un mail à contact@votrenomdedomaine.fr - si vous avez respecté toutes les étapes ci-dessus alors vous devriez recevoir le message dans votre boîte mail en quelques secondes.

Dans un prochain tuto, nous verrons comment intégrer très simplement un formulaire de contact sur votre site. Pour ceux qui souhaiteraient prendre un peu d'avance, n'hésitez pas à jeter un oeil sur [Form Keep](https://formkeep.com/) ou [Brace Form](http://forms.brace.io/?redirected=yes).

### Liens utiles

- [OVH](https://www.ovh.com/fr/index.xml)
- [OVH Manager](https://www.ovh.com/manager/web/login/)

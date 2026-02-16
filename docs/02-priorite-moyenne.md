# Priorité moyenne (moyen terme)

Sécurité, UX et fonctionnalités déjà prévues par les modèles.

---

## 1. Authentification

**Problème :** La gem `bcrypt` est commentée dans le Gemfile ; aucune session ni mot de passe. Impossible de savoir « qui » est connecté et de protéger les actions sensibles.

**À faire :**
- Décommenter et ajouter `gem "bcrypt", "~> 3.1.7"` dans le Gemfile, puis `bundle install`.
- Dans le modèle `User`, ajouter `has_secure_password` et une migration pour la colonne `password_digest`.
- Créer un `SessionsController` (login/logout) et des routes associées.
- Protéger les actions de création/édition/suppression (et éventuellement l’affichage d’infos sensibles) par un `before_action :require_login` (ou équivalent).

Alternative : utiliser Devise pour gérer inscription, connexion, récupération de mot de passe, etc.

---

## 2. Données sensibles (email)

**Problème :** La page utilisateur affiche l’email en clair pour tous les visiteurs.

**À faire :** Afficher l’email uniquement pour l’utilisateur connecté (ou un admin). Par exemple dans la vue : `<% if current_user&.id == @user.id %> ... email ... <% end %>`. Adapter selon ton système de rôles si besoin.

---

## 3. Paramètre welcome (first_name)

**Problème :** `params[:first_name]` est affiché sans contrôle (longueur, caractères).

**À faire :** Limiter ou sanitizer la valeur (longueur max, strip, ou validation côté contrôleur) pour éviter des abus (texte très long, caractères spéciaux). L’échappement HTML protège déjà contre les injections XSS, mais une limite évite des contenus inappropriés.

---

## 4. Afficher les tags sur les gossips

**Problème :** Le modèle `Gossip` a `has_many :tags, through: :gossip_tags`, mais les vues ne les affichent pas.

**À faire :**
- Sur la page d’accueil (cartes gossip) : afficher les tags associés à chaque gossip (ex. badges).
- Sur la page `gossips/show` : afficher la liste des tags du gossip.
- Éviter les N+1 : utiliser `Gossip.includes(:user, :tags)` (ou `tags` via la jointure) là où tu listes des gossips avec leurs tags.

---

## 5. Afficher les commentaires sur la page gossip

**Problème :** Le modèle `Comment` existe et est lié aux gossips, mais la page show d’un gossip ne liste pas les commentaires.

**À faire :**
- Dans `GossipsController#show`, s’assurer que les commentaires sont chargés (ex. `@gossip.comments` ou `@gossip.comments.includes(:user)` pour éviter N+1).
- Dans `app/views/gossips/show.html.erb`, ajouter une section « Commentaires » qui affiche la liste des commentaires (auteur, contenu, date). Plus tard : formulaire d’ajout de commentaire (nécessite authentification).

---

## 6. Routes en style « ressource »

**Problème :** Routes manuelles en `get` ; pas de `resources` pour gossips/users.

**À faire :** Passer à un style ressource pour préparer le CRUD, par exemple :

```ruby
resources :gossips, only: [:index, :show]   # puis étendre à new, create, edit, update, destroy
resources :users, only: [:show]
```

Conserver `root "pages#home"` si la home actuelle reste la page d’accueil. Adapter les helpers dans les vues si les URLs changent (ex. `gossips_path` pour l’index).

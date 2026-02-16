# Priorité basse (plus tard)

Fonctionnalités avancées et polish.

---

## 1. CRUD complet des gossips

**Contexte :** Une fois l’authentification en place, permettre de créer, modifier et supprimer des gossips (avec vérification que l’auteur est l’utilisateur connecté).

**À faire :**
- Ajouter les actions `new`, `create`, `edit`, `update`, `destroy` dans `GossipsController`.
- Étendre les routes : `resources :gossips` (ou `only: [:index, :show, :new, :create, :edit, :update, :destroy]`).
- Créer les vues `new.html.erb` et `edit.html.erb` avec des formulaires (form_with + model).
- Utiliser le strong parameters : `params.require(:gossip).permit(:title, :content)`.
- Avant `edit` / `update` / `destroy`, vérifier que `current_user` est bien l’auteur du gossip (ou admin).

---

## 2. Likes

**Contexte :** Le modèle `Like` (polymorphique) existe ; pas d’interface pour liker un gossip ou un commentaire.

**À faire :**
- Afficher le nombre de likes sur chaque gossip (et éventuellement sur les commentaires).
- Ajouter un bouton « Like » (ou lien) qui crée/supprime un like pour l’utilisateur connecté. Une seule route (toggle) ou deux (create / destroy) selon le design.
- Gérer l’unicité : un utilisateur ne peut liker qu’une fois un même gossip/commentaire (validation ou index unique en base).

---

## 3. Messages privés

**Contexte :** Modèles `PrivateMessage` et `PrivateMessageRecipient` en place ; aucune page pour les lire ou en envoyer.

**À faire :**
- Une page « Boîte de réception » listant les messages reçus par l’utilisateur connecté.
- Une page « Envoyer un message » (formulaire : destinataire(s), contenu).
- Une page « Détail d’un message » (optionnel).
- Contrôler que seuls l’expéditeur et les destinataires peuvent voir le message.

---

## 4. Pagination

**Problème :** Avec beaucoup de gossips (seed ou production), la liste sur la home peut devenir très longue.

**À faire :** Utiliser une gem de pagination (kaminari ou pagy), puis dans le contrôleur : `@gossips = Gossip.includes(:user).order(created_at: :desc).page(params[:page])` et en vue afficher les liens de pagination.

---

## 5. Corrections de typo et textes

**À faire :** Dans les vues, corriger par exemple :
- « triees » → « triées »
- « publie(s) » → « publié(s) »
- « a part » → « à part »
- « publies » → « publiés » (dans « Gossips publies »)

---

## 6. SEO et accessibilité

**Problème :** Le titre de la page est identique partout (« TheGossipProject »).

**À faire :**
- Utiliser `content_for :title` dans le layout et définir un titre par page (ex. titre du gossip, nom de l’utilisateur).
- Vérifier les balises sémantiques et les attributs ARIA si besoin pour l’accessibilité.

---

## 7. Internationalisation (i18n)

**Optionnel :** Si le projet doit être multilingue, déplacer les chaînes des vues et contrôleurs dans des fichiers de locale (ex. `config/locales/fr.yml`) et utiliser `t('key')` dans les vues.

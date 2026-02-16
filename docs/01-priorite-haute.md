# Priorité haute (court terme)

Améliorations à faire en premier : robustesse, tests et performance.

---

## 1. Gestion des erreurs 404 (RecordNotFound)

**Problème :** `Gossip.find(params[:id])` et `User.find(params[:id])` lèvent une exception si l’id n’existe pas, ce qui renvoie une page 500 au lieu d’une 404.

**À faire :** Dans `ApplicationController`, ajouter :

```ruby
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

private

def record_not_found
  render file: Rails.public_path.join("404.html"), layout: false, status: :not_found
end
```

Ou utiliser un `before_action` avec `set_gossip` / `set_user` et rescuer `ActiveRecord::RecordNotFound` pour rendre la 404.

---

## 2. Corriger les tests d’intégration

**Problème :** Les tests utilisent `gossips_show_url` et `users_show_url`, qui ne correspondent pas aux routes (nommées `gossip` et `user` avec un paramètre `:id` obligatoire).

**À faire :**
- Créer des fixtures pour `users` et `gossips` dans `test/fixtures/`.
- Remplacer `get gossips_show_url` par `get gossip_url(gossips(:one))` (ou un id cohérent).
- Remplacer `get users_show_url` par `get user_url(users(:one))`.

Cela permet de tester réellement les pages show avec des données valides.

---

## 3. Éviter les requêtes N+1 sur la home

**Problème :** `@gossips = Gossip.all` puis en vue `gossip.user.first_name` pour chaque gossip → une requête SQL par gossip.

**À faire :** Dans `PagesController#home` :

```ruby
@gossips = Gossip.includes(:user).order(created_at: :desc)
```

Adapter l’ordre si besoin (par exemple par date de mise à jour).

---

## 4. Validations minimales sur les modèles principaux

**Problème :** Aucune validation dans les modèles ; des enregistrements incohérents (champs nil, doublons) sont possibles.

**À faire :** Ajouter au minimum :

- **User :** `validates :first_name, :last_name, :email, :city_id, presence: true` ; `validates :email, uniqueness: true` ; optionnel : format email, `age` numérique.
- **Gossip :** `validates :title, :content, :user_id, presence: true` ; optionnel : longueur max pour `title` et `content`.
- **Comment :** `validates :content, :user_id, :gossip_id, presence: true`.
- **City :** `validates :name, :zip_code, presence: true`.
- **Tag :** `validates :title, presence: true`.
- **PrivateMessage :** `validates :content, :sender_id, presence: true`.

Cela sécurise les données et prépare les messages d’erreur pour les futurs formulaires.

# Passage à Rails 8

Les modifications suivantes ont été appliquées pour préparer Rails 8 :

- **Gemfile** : `rails "~> 7.1.3"` → `rails "~> 8.0"`
- **Gemfile** : suppression du pin `minitest "~> 5.27"` (Rails 8 est compatible avec Minitest 6)
- **config/application.rb** : `config.load_defaults 7.1` → `config.load_defaults 8.0`

## À faire de ton côté

1. **Mettre à jour les gems** (depuis la racine du projet) :
   ```bash
   bundle update rails
   ```

2. **Préparer la base de test et lancer les tests** :
   ```bash
   bundle exec rails db:test:prepare test
   ```

3. **Optionnel** : lancer la tâche de mise à jour Rails pour comparer la config :
   ```bash
   bin/rails app:update
   ```
   Tu peux refuser les écrasements et garder ta config actuelle ; l’outil propose des fichiers comme `config/initializers/new_framework_defaults_8_0.rb` si tu préfères activer les nouveaux défauts progressivement.

## Prérequis

- **Ruby** : Rails 8.0 demande Ruby 3.2.0 ou plus récent (tu es en 3.4.2, c’est bon).

## Principaux changements Rails 8

- Kamal 2, Thruster, Solid Cable / Cache / Queue, Propshaft par défaut (déjà utilisés dans ce projet).
- Compatibilité Minitest 6.
- Voir [Rails 8.0 Release Notes](https://guides.rubyonrails.org/8_0_release_notes.html) et [Upgrading Ruby on Rails](https://guides.rubyonrails.org/upgrading_ruby_on_rails.html).

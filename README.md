# 🗞️ The Gossip Project – Full CRUD

A Ruby on Rails application built as part of **The Hacking Project** bootcamp (THP).  
Goal: implement a **full CRUD** on gossips, plus a partial CRUD on **comments**, with navigation between **users**, **cities**, and **tags**, and a dark-themed **Bootstrap** UI.

---

## 🧩 Main Features

### 🏠 Homepage (`/`)
- Lists all gossips as cards.
- For each gossip:
  - 👤 Author first name
  - 🗣️ Title
  - ✂️ Truncated content
  - 💬 Number of related comments
  - 🔗 “Lire le dossier” button linking to the gossip show page.

### 🔎 Gossip – Show (`/gossips/:id`)
- Displays:
  - 📝 Title  
  - 📖 Full content  
  - 👤 Author (with link to user profile)  
  - 🏙️ Author’s city (with link to city page)  
  - 🏷️ Tags associated with the gossip  
- Actions:
  - ✏️ Edit gossip  
  - 🗑️ Delete gossip (only for the author, with `current_user == @gossip.user`)  
- Comments:
  - 📥 Form to **add a comment** to the gossip  
  - 📜 List of comments with:
    - Comment author  
    - Comment text  
    - “Modifier” link to the comment edit page  

### ✏️ Gossips – New / Edit
- Form for creating and editing a gossip:
  - `title`
  - `content`
  - `tag` (select an existing tag via dropdown)
- After create / update:
  - Redirects to the gossip show page.

### 💣 Destroy Gossip
- From the gossip show page:
  - “Supprimer” button deletes the gossip and **all its comments** (`dependent: :destroy`).
  - Redirects to the index (homepage).

### 👤 User – Show (`/users/:id`)
- Displays:
  - First name, last name  
  - Description  
  - Email  
  - Age  
  - City (with link to city page)  
  - Number of published gossips  
- Lists all gossips by the user, with actions:
  - If it’s the `current_user`: edit / delete  
  - Otherwise: read-only access  

### 🏙️ City – Show (`/cities/:id`)
- Displays:
  - City name  
  - Zip code  
- Lists all gossips published by users from that city, using the same card style as the homepage.

### 💬 Comments
- Created from the gossip show page.  
- Edited / deleted via dedicated routes:
  - `comments#edit`, `comments#update`, `comments#destroy`  
- Each comment belongs to:
  - a `User` (either `current_user` or a seeded user),
  - a `Gossip`.

### 🏷️ Tags
- 10 tags are created in the seed.  
- When creating or editing a gossip:
  - Select one tag from existing tags.  
  - Association is handled through the `GossipTag` join model.  
- Tags are rendered as badges on the gossip show page.

### 🧭 Static Pages & Navigation
- `/team`, `/contact`, `/welcome/:first_name`  
- Bootstrap header with:
  - Links: Home, Team, Contact  
  - Session handling (login/logout + profile access)  
- Global UI uses **Bootstrap 5** (CDN) with a dark theme.

---

## 🛠️ Tech Stack

- 💎 Ruby 3.4.2  
- 🚂 Rails 7.1.x  
- 🗄️ SQLite3  
- 🎨 Bootstrap 5 (CDN)  
- 🎲 Faker (for seeds)  

---

## 🗄️ Models & Associations

Main models:

- 🏙️ `City` – has_many `users`, has_many `gossips` **through** `users`  
- 👤 `User` – belongs_to `city`, has_many `gossips`, has_many `comments`, has_many `likes`  
- 🗣️ `Gossip` – belongs_to `user`, has_many `comments`, has_many `tags` **through** `gossip_tags`, has_many `likes` (polymorphic)  
- 💬 `Comment` – belongs_to `user`, belongs_to `gossip`, has_many `likes` (polymorphic)  
- 🏷️ `Tag` – has_many `gossips` **through** `gossip_tags`  
- 🔗 `GossipTag` – join model between `gossip` and `tag`  
- 📩 `PrivateMessage` & 📬 `PrivateMessageRecipient` – private messaging between users  
- ❤️ `Like` – polymorphic like on `Gossip` and `Comment`  

---

## 🌱 Seeding

The database seed (`db/seeds.rb`) uses Faker to generate French, office-style data:

- 🏙️ 10 cities  
- 👤 10 users with description, age, city  
- 🗣️ 20 gossips  
- 🏷️ 10 tags  
- 🔗 `GossipTag` relations (1–3 tags per gossip)  
- 📩 Private messages + recipients  
- 💬 20 comments (without the `(source: tkt)` suffix)  
- ❤️ 20 likes  

To fully reset and seed the database:

```bash
bin/rails db:drop db:create db:migrate db:seed
```

---

## 🚀 Installation & Run

```bash
# Install gems
bundle install

# Prepare DB (create + migrate + seed)
bin/rails db:setup
# or
bin/rails db:create db:migrate db:seed

# Start dev server (Rails + assets)
bin/dev
```

App will be available at `http://localhost:3000`.

---

## 🌳 File Tree (simplified)



```
the_gossip_project
│
├── 📁 .github
│   ├── 📁 workflows
│   │   └── ⚙️ ci.yml
│   └── ⚙️ dependabot.yml
├── 📁 .kamal
│   ├── 📁 hooks
│   │   ├── 📄 docker-setup.sample
│   │   ├── 📄 post-app-boot.sample
│   │   ├── 📄 post-deploy.sample
│   │   ├── 📄 post-proxy-reboot.sample
│   │   ├── 📄 pre-app-boot.sample
│   │   ├── 📄 pre-build.sample
│   │   ├── 📄 pre-connect.sample
│   │   ├── 📄 pre-deploy.sample
│   │   └── 📄 pre-proxy-reboot.sample
│   └── 📄 secrets
├── 📁 app
│   ├── 📁 assets
│   │   ├── 📁 images
│   │   │   └── ⚙️ .keep
│   │   └── 📁 stylesheets
│   │       └── 🎨 application.css
│   ├── 📁 controllers
│   │   ├── 📁 concerns
│   │   │   └── ⚙️ .keep
│   │   ├── 💎 application_controller.rb
│   │   ├── 💎 gossips_controller.rb
│   │   ├── 💎 pages_controller.rb
│   │   └── 💎 users_controller.rb
│   ├── 📁 helpers
│   │   ├── 💎 application_helper.rb
│   │   ├── 💎 gossips_helper.rb
│   │   ├── 💎 pages_helper.rb
│   │   └── 💎 users_helper.rb
│   ├── 📁 javascript
│   │   ├── 📁 controllers
│   │   │   ├── 📄 application.js
│   │   │   ├── 📄 hello_controller.js
│   │   │   └── 📄 index.js
│   │   └── 📄 application.js
│   ├── 📁 jobs
│   │   └── 💎 application_job.rb
│   ├── 📁 mailers
│   │   └── 💎 application_mailer.rb
│   ├── 📁 models
│   │   ├── 📁 concerns
│   │   │   └── ⚙️ .keep
│   │   ├── 💎 application_record.rb
│   │   ├── 💎 city.rb
│   │   ├── 💎 comment.rb
│   │   ├── 💎 gossip.rb
│   │   ├── 💎 gossip_tag.rb
│   │   ├── 💎 like.rb
│   │   ├── 💎 private_message.rb
│   │   ├── 💎 private_message_recipient.rb
│   │   ├── 💎 tag.rb
│   │   └── 💎 user.rb
│   └── 📁 views
│       ├── 📁 gossips
│       │   └── 📄 show.html.erb
│       ├── 📁 layouts
│       │   ├── 📄 application.html.erb
│       │   ├── 📄 mailer.html.erb
│       │   └── 📄 mailer.text.erb
│       ├── 📁 pages
│       │   ├── 📄 contact.html.erb
│       │   ├── 📄 home.html.erb
│       │   ├── 📄 team.html.erb
│       │   └── 📄 welcome.html.erb
│       ├── 📁 pwa
│       │   ├── 📄 manifest.json.erb
│       │   └── 📄 service-worker.js
│       └── 📁 users
│           └── 📄 show.html.erb
├── 📁 config
│   ├── 📁 environments
│   │   ├── 💎 development.rb
│   │   ├── 💎 production.rb
│   │   └── 💎 test.rb
│   ├── 📁 initializers
│   │   ├── 💎 assets.rb
│   │   ├── 💎 content_security_policy.rb
│   │   ├── 💎 filter_parameter_logging.rb
│   │   └── 💎 inflections.rb
│   ├── 📁 locales
│   │   └── ⚙️ en.yml
│   ├── 💎 application.rb
│   ├── 💎 boot.rb
│   ├── ⚙️ bundler-audit.yml
│   ├── ⚙️ cable.yml
│   ├── ⚙️ cache.yml
│   ├── 💎 ci.rb
│   ├── 📄 credentials.yml.enc
│   ├── ⚙️ database.yml
│   ├── ⚙️ deploy.yml
│   ├── 💎 environment.rb
│   ├── 💎 importmap.rb
│   ├── 📄 master.key
│   ├── 💎 puma.rb
│   ├── ⚙️ queue.yml
│   ├── ⚙️ recurring.yml
│   └── 💎 routes.rb
├── 📁 db
│   ├── 📁 migrate
│   │   ├── 💎 20260212124226_create_cities.rb
│   │   ├── 💎 20260212124235_create_users.rb
│   │   ├── 💎 20260212124243_create_gossips.rb
│   │   ├── 💎 20260212125007_create_tags.rb
│   │   ├── 💎 20260212125015_create_gossip_tags.rb
│   │   ├── 💎 20260212125842_create_comments.rb
│   │   ├── 💎 20260212130718_create_private_messages.rb
│   │   ├── 💎 20260212130741_create_private_message_recipients.rb
│   │   ├── 💎 20260212142052_rebuild_private_message_recipients.rb
│   │   └── 💎 20260212143955_create_likes.rb
│   ├── 💎 cable_schema.rb
│   ├── 💎 cache_schema.rb
│   ├── 💎 queue_schema.rb
│   ├── 💎 schema.rb
│   └── 💎 seeds.rb
├── 📁 lib
│   └── 📁 tasks
│       └── ⚙️ .keep
├── 📁 public
│   ├── 🌐 400.html
│   ├── 🌐 404.html
│   ├── 🌐 406-unsupported-browser.html
│   ├── 🌐 422.html
│   ├── 🌐 500.html
│   ├── 🖼️ icon.png
│   ├── 🖼️ icon.svg
│   └── 📄 robots.txt
├── 📁 script
│   └── ⚙️ .keep
├── 📁 test
│   ├── 📁 controllers
│   │   ├── ⚙️ .keep
│   │   ├── 💎 gossips_controller_test.rb
│   │   ├── 💎 pages_controller_test.rb
│   │   └── 💎 users_controller_test.rb
│   ├── 📁 fixtures
│   │   └── 📁 files
│   │       └── ⚙️ .keep
│   ├── 📁 helpers
│   │   └── ⚙️ .keep
│   ├── 📁 integration
│   │   └── ⚙️ .keep
│   ├── 📁 mailers
│   │   └── ⚙️ .keep
│   ├── 📁 models
│   │   └── ⚙️ .keep
│   └── 💎 test_helper.rb
├── 📁 vendor
│   ├── 📁 javascript
│   │   └── ⚙️ .keep
│   └── ⚙️ .keep
├── ⚙️ .dockerignore
├── ⚙️ .gitattributes
├── ⚙️ .gitignore
├── ⚙️ .rubocop.yml
├── 🐳 Dockerfile
├── 📄 Gemfile
├── 📝 README.md
├── 📄 Rakefile
└── 📄 config.ru
```


## 🎯 THP Expected Output

An application named `the_gossip_project` that:

- Implements full CRUD on **gossips**  
- Implements partial CRUD on **comments**  
- Provides show pages for **gossip**, **user**, and **city**  
- Uses **RESTful routes** (`resources`)  
- Uses **Bootstrap** for styling and navigation  

---

👨‍💻 Author: Vincent Michel  
🎓 The Hacking Project Bootcamp

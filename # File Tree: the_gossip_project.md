# File Tree: the_gossip_project

**Generated:** 2/16/2026, 3:56:12 AM
**Root Path:** `/home/toxy/dossierlinux/week7/lundi/the_gossip_project/the_gossip_project`

```
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

---
*Generated by FileTree Pro Extension*
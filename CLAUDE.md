# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Tech Stack

- **Backend**: Rails 7.0.8, Ruby 3.1.2, PostgreSQL
- **Auth**: Devise (confirmable, lockable, timeoutable, trackable) + Rolify + CanCanCan
- **Frontend**: HAML templates, SCSS, Foundation 6, Hotwire (Turbo + Stimulus), Importmap
- **File uploads**: CarrierWave (profile pictures → `public/uploads/`)
- **Testing**: RSpec + Minitest (both coexist), Capybara + Selenium for system tests
- **Node**: 18.20.8 (`.nvmrc`), Yarn for CSS build

## Development Commands

```bash
# First-time setup
bin/setup

# Run dev server (web + CSS watcher in parallel)
bin/dev

# Rails commands
bin/rails server          # web only, port 3000
bin/rails console
bin/rails db:migrate
bin/rails routes

# CSS build
yarn build:css            # one-shot
yarn build:css --watch    # watch mode (included in bin/dev)

# Tests
bundle exec rspec                        # all RSpec specs
bundle exec rspec spec/models/user_spec.rb  # single spec file
bin/rails test                           # all Minitest tests
bin/rails test test/models/user_test.rb  # single Minitest file
```

## Database Setup

Copy the example config and fill in your credentials:
```bash
cp config/database.yml.example config/database.yml
bin/rails db:create db:migrate db:seed
```

Requires PostgreSQL running locally and Redis for Action Cable.

## Architecture

**Namespace structure**: Authenticated routes live under the `User::` namespace (`app/controllers/user/`, `app/views/user/`). Public routes use `PublicController`. `ApplicationController` enforces authentication for all non-public routes.

**Authorization**: CanCanCan abilities are defined in `app/models/ability.rb`. Users can only manage their own posts and comments. Roles are assigned via Rolify (default role: `"user"` on account creation).

**Real-time UI**: Controllers respond with Turbo streams (`.turbo_stream` format) for in-place DOM updates — no full page reloads. See `User::PostsController` and `User::CommentsController` for examples.

**Comments display**: Limited to 3 per post by default (`Comment::TOTAL_COMMENTS_TO_DISPLAY`). "See all / see less" toggles are custom POST actions wired through Turbo streams.

**Devise configuration** (notable non-defaults):
- Paranoid mode enabled
- Idle timeout: 30 minutes
- Account lockout after 3 failed attempts
- Password reset tokens valid for 6 hours
- Email confirmation required on sign-up

## Key Files

| File | Purpose |
|---|---|
| `config/routes.rb` | All routes; user resources nested under `/user` namespace |
| `app/models/ability.rb` | CanCanCan authorization rules |
| `app/models/user.rb` | Devise modules, Rolify, CarrierWave mount |
| `app/uploaders/profile_picture_uploader.rb` | CarrierWave uploader config |
| `db/schema.rb` | Authoritative database schema |
| `spec/rails_helper.rb` | RSpec configuration |

## WIP Features

The following features are not yet implemented and are tracked for future work: friendships/followers, newsfeed, notifications, and search.

# Things you want to know

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  - 3.1.2

* Relational Database
  - [PostgreSQL](https://www.postgresql.org/)

* Database initialization
  - Create `database.yml` file inside `/config` folder.
  - Copy the code on the `database.yml.example` and paste it on `database.yml` then save.
  - Update values on your `database.yml`
    - Change the `database` value under **development, test and production** base on your preference
    - Change the values on username and password under `development_credential` for development environment
    - Change the values on username and password under `production` for production environment

* Deployment instructions

# FEATURE

* Access
  - Login/Sign up
  - Forgot/Reset password - Reset password within 6 hours
  - Confirmation of account
  - Lock/Unlock Account - 3 login failed attempts
  - Idle in 30 minutes user will logout
# Things you want to know

* Ruby version
  - 3.1.2
* Node version
  - 18

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

# FEATURES

* Access
  - Login/Sign up
  - Forgot/Reset password - Reset password within 6 hours
  - Confirmation of account
  - Lock/Unlock Account - 3 login failed attempts
  - Idle in 30 minutes user will logout

* Manage their accounts.
  - Change Email/Username
  - Change password
    - New Password
    - Retype new password
* Profile creation: 
  - Allow users to create and edit their own personal profiles, including uploading profile pictures and adding bio information.
* Posts and comments
  - Users should be able to create, edit, and delete their own posts and comments.
* [WIP]Friendships and follower system
  - Implement a system for users to send friend requests and follow other users.
* [WIP]Newsfeed
  - Display posts from friends and people the user follows in a chronological order.
* [WIP]Notifications
  - Notify users of new friend requests, comments, and likes on their posts.
* [WIP]Search functionality
  - Allow users to search for other users and posts by keywords or hashtags.

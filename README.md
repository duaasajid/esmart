# Intro

ESMart (E-Sports Mart) is an upcoming marketplace for gamers.

Gamers will be able to compete in e-sports (games) and earn prizes by winning games, with a nominal participation fee.

It's still in its early iterations, but many new exciting features are coming. 

# Entities

The following entities (models) interact on our platform:

* **Users** sign up to our app
* We support a number of **Games**
* A User can have a **GamerProfile** for one or more Games (they can only play games they have configured a profile for)
* Users participate in 1vs1 **Matches** and gather 1 point for each match won

Eventually users will be able to enter matches by paying some tokens and buy stuff with points won from our marketplace, but we currently are in free-play mode.

Multi-player will also be supported at some time to allow for lower participation fees per match, but that's for another time.

# Fork

You can fork this app to your own account to make required changes.

# Deliverables

* The coding part of the assignment should be committed to your fork of the repo, you can then share your forked repo with us
* The trivia part (and your thought about any tasks you opted to skip) you can add to the email you'll share the repo in

You can address your email to:

savvas@welcomepickups.com

# Configuration

Copy file `.env_sample` to `.env` and replace the env variable values so that they make sense for your environment.

# Running the app

- Install ruby `2.5.1` using [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://rvm.io/)
- Install bundler 
```
gem install bundler -v "$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"
```
- Install webpack dependencies
```
yarn install
```
- Configure your DB connection and run
```
rails db:create && rails db:schema:load
```

# Seeds

After setting up your database, you can populate it with some sample data running:

    rake db:seed

# Starting the webserver
To start the web server and sidekiq you can execute:

    foreman start -f Procfile.dev

[Foreman](https://github.com/ddollar/foreman) will start the following processes:
1. rails server
2. sidekiq 
3. webpack dev server (in development)

The app will be available at:

    http://lvh.me:5000/

If you have seeded the db, you'll be able to sign in using any of the emails:

* ken@capcom.com
* ryu@capcom.com

and password `12345678` (über secure, don't tell anyone!).

# TODOs

The following parts concern TODOs for our app for the upcoming "Sprint".

Please try to do them in the order they are listed and implement each task **in its own commit**.

Tasks that are marked *optional* can be skipped, but it's useful to go through them and at the very least think of how you would go about implementing them.

## #1 Git

We were so absorbed testing with fixture data that we forgot to check what happens when a new user signs up.

Turns out we crash when the main dashboard is rendered because our code expects a user avatar to exist (oops).

This will probably bite us if we create other types of records with missing images as well.

In the repo there is a hotfix branch ready to be merged which addresses these issues.

The branch name is:

    default_image_support

Can you close this branch on master with as clean a git history as possible?
There are some fix commits in there we ideally don't want to have "polluting" master.

You'll need this fix to be unblocked for the rest of the tasks, so at the very least, just merge it to `master` if in doubt.

## #2 Test coverage (Optional)

We started out with the best intentions to test whatever we write, but in classic startup fashion we got side-tracked. :-(

Can you improve test coverage for the app? No need to test everything, but do try to focus on the most critical business logic.

In your email to us, please include 1-2 sentences on why you chose to test what you did.

## Bug fixes

### #3 GDPR purge task

Oddly, the project team insisted we incorporate GDPR provisions from the get-go.
Better safe than sorry we suppose.

Per our implementation of GDPR, all users that have cancelled their accounts more that one month ago should be purged, along with their data. Account cancellation is a soft-delete, with hard deletion happening in a delayed fashion.

This is done via a rake task that is run every day.

The task is:

    rake gdpr:purge

There seem to be a couple of bugs with current implementation though:

1. Soft-deleted users can still log in (!?). How can this be? This is a major bug...
2. The GDPR task doesn't seem to delete all associated records and we are left with orphans
3. After hard deletion, a few things break down because of references to users that no longer exist

**Note:** Scores for existing users should not be affected by deletion of inactive users, also you'll see there's a problem with how we track winners and maybe that should be changed to accommodate for user deletions.

**Hint:** The fix for 1 is a one-liner. Actually, even less than a one liner... ;-)

Can you fix the above issues?

## Performance improvements

### #4 User stats

There is something fishy about the way the user stats are calculated on the main dashboard.

The numbers are correct, but:

1. We do a count for all matches where the current user is the winner
2. We calculate matches played and won ruby-side, instead of in the db
3. We unnecessarily load full Match objects even though we don't need most Match attributes

There's got to be a way to return this info with fewer queries and without loading so many ruby objects...

Can you improve on this?

### #5 N+1

Can you locate and fix the N+1 queries on the `games#index` page?

### #6 Expensive operation

Whenever a user signs up, we fetch their Anti-Cheat Reputation from a 3rd party service based on their email.

Unfortunately, this 3rd party service currently has a very poor SLA and response time is at times > 5 seconds. Not only that, but we are using their SDK which often errors out, making our app crash.

They have promised to improve on that in their next version, but we can't wait for them to deliver.

Our marketing team warns us that many people will just abandon the sign-up process unless we speed it up and make the process less "crashy".

Requirements:

* It's not critical that we have this reputation score upon sign-up, we can live with it being fetched out-of-band
* We also want the operation to be retried in the case of an error or timeout

Can you handle his improvement?

You can use a gem already in the Gemfile to tackle this.

### #7 Api caching

While the app doesn't really do much (at the moment), we have decided to start with an API early on.

Currently we only expose the list of games we support.

Can you implement caching for this endpoint so that we don't hit the db needlessly every time this endpoint is called?

When would it make sense for this cache to expire?

## #8 Error reporting (Optional)

The app uses [rollbar](https://rollbar.com/) for error reporting. You'll need to sign up to rollbar and create a project to be able to complete this task. 

Currently we explicitly report errors occurring whenever we use the super buggy SDK from our Anti-Cheat Reputation provider.

Can you check the [rollbar documentation](https://docs.rollbar.com/docs/ruby#section-getting-started) and find pass more info to the error notification so that we have some context?

* user.id
* user.email
* request.remote_ip (if available)
* request.user_agent (if available)

**Note:** Seems we are not covering all errors that the Anti-Cheat client can throw...

## New features

### #9 Email confirmation (Optional)

We unfortunately didn't implement user email confirmation in this early version of our app and we fear we're going to have a lot of fraudulent sign-ups.

Can you implement email confirmation for our User model?
Preferably use functionality offered by the gems we already have, instead of rolling your own.

## #10 Username support (Optional)

Beta-testers have reported that they would prefer to be able to set their username upon sign-up.

To be honest, showing emails in matches is pretty ugly as well.

Users should also be able to *sign in* providing either their username or email.

Can you add this functionality?

You'll find that [devise](https://github.com/plataformatec/devise), the authentication gem used, has documentation on how to implement this.

### #11 Reputation re-check

We currently set the User reputation only once upon sign-up.

It would be better if we checked the player's reputation periodically, e.g. in a daily rake task.
This way if a player's reputation improves or worsens, we will be up to date.

Your mission, should you choose to accept it, is to create the aforementioned rake task.

**Note:** You don't need to set up the daily interval yourself, this will be handled by [heroku scheduler](https://devcenter.heroku.com/articles/scheduler) on production.

### #12 Game API url validation

As it is, the `api_url` the `Game` model is not checked for validity.

Can you write a URL validation conforming to the following specs?

1. It need only validate the URL format, no need to actually check DNS lookup / connectivity etc
2. It should be re-usable in case we add URL attributes to other models

### #13 Start Match Functionality (Optional)

Our app has no page yet for users to start a match.

Can you implement `matches#new` and `matches#create` endpoints with the following specs?

* User can select a game from a dropdown
* Dropdown should list only games a user has a gamer profile for
* Upon selecting a game, the user should be able to select their opponent from a second dropdown
* The opponent dropdown should list users other than oneself that have a gamer profile for the same game
* The second dropdown should be dynamically populated based on the game and without a full page reload
* After selecting a game and opponent, user should be able to submit a new match

Validation should also happen on the controller level: the controller should not accept a match for users without the necessary gamer profiles for said games, even if the UI prevents it in the first place.

Feel free to add any validation / policy necessary to enforce this on the backend.

### #14 API auth

Our API currently doesn't check for proper authorization, it just returns results to anyone without access control.

Let's do something about that:

1. We will be issuing API keys to 3rd parties
2. Each API key should be unique in the db
3. Each API key should be revocable (it should be able revoke a key without deleting it)
4. Clients should pass the key in the `Authorization` header

Create a model that conforms to the above specifications and use it when authorizing API access.

Assume API tokens will be created by an admin via the console for the time being, given that we don't have an admin UI yet.

Don't forget to test whatever you write!

### #15 Styling (Optional)

Our sign in page, offered by devise, is "kind of" poorly styled.

Can you apply bootstrap styles to the following templates?

* Sign in page
* Registration edit page
* Forgot password page
* Resend confirmation email page

## Trivia

Please share your thoughts about the following points in 1-2 sentences max:

* Can you think of some input validation that is missing from all forms / models of the app?

* Would the current model validations suffice in a multi-process / multi-threaded server environment?

* What is your opinion on the `fetch_reputation` callback in the User model?

* We are currently storing model attachments (avatars, logos, etc.) on the file system. Do you anticipate a problem with this if we choose to deploy to heroku?

* Currently game results are populated manually by admins (oracles) but this is becoming unwieldy. If we are really serious about the future we have to collect game results automatically. How do you envision this would work?

* Our current association of users with matches is pretty terrible... What would need to change to support multi-player matches?

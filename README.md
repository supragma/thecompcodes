[![codecov](https://codecov.io/gh/supragma/thecompcodes/branch/master/graph/badge.svg)](https://codecov.io/gh/supragma/thecompcodes)

CircleCI:
[![supragma](https://circleci.com/gh/supragma/thecompcodes.svg?style=svg)](https://circleci.com/gh/supragma/thecompcodes)
# README

* Ruby version
```2.7.1```

* Configuration
Environment variables must be set for SendGrid and in CircleCI.

These environment variables include:
- SENDGRID_API_KEY
- SENDGRID_USERNAME
- CODECOV_TOKEN

* How to run the test suite

```rake test```

* How to do migrations of the database on production (skip heroku command if local)

```heroku run:bash```

```rails db:migrate```

* Deployment instructions
Deployment is manually on the heroku page


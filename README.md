# Ruby Levenshtein Distance Calculation
This is an attempt at calclating Levenshtein distance between emails.

# Environment
ruby-2.6.3
rails 6.0.1
postgres >= 9.3

# Application Setup
1. Clone this repo
2. Run `make setup`
3. Modify the .env file with your credentials
4. Run `make server`
5. Navigate to `localhost:3000`

# Devleopment Setup
```
rails new ruby-levenshtein-example --database=postgresql --skip-action-mailer --skip-action-mailbox
rake db:setup
rails generate rspec:install
rails g model users first_name:text last_name:text display_name:text email:text title:text ss_data:jsonb
```

# Testing
1. Run `make test`
Warning: Currently using beta `gem 'rspec-rails', '~> 4.0.0.beta3'` due to bug listed here: https://stackoverflow.com/questions/58581334/generated-rspec-controller-test-is-failing-with-wrong-number-of-arguments-given

# Ruby Levenshtein Distance Calculation
This is an attempt at calclating Levenshtein distance between emails.

# Environment
ruby-2.6.3
rails 6.0.1
postgres >= 9.3

# Application Setup
1. Clone this repo
2. Run `make setup`
3. Run `make server`
4. Navigate to `localhost:3000`

# Devleopment Setup
`rails new ruby-levenshtein-example --database=postgresql --skip-action-mailer --skip-action-mailbox`
`rake db:setup`

# Testing
1. Run `make test`
Warning: Currently using beta `gem 'rspec-rails', '~> 4.0.0.beta3'` due to bug listed here: https://stackoverflow.com/questions/58581334/generated-rspec-controller-test-is-failing-with-wrong-number-of-arguments-given

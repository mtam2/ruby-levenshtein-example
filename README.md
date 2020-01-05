# Ruby Levenshtein Distance Calculation
This is an attempt at calclating Levenshtein distance between emails.

# Environment
- ruby-2.6.3
- rails 6.0.1
- postgres >= 9.3

# Application Setup
1. Clone this repo
2. Run `make setup`
3. Modify the .env file with your credentials
4. Run `make server`
5. Navigate to `http://localhost:3000/`
6. Click on Refresh Data

Optional:

7. run `make calculate_dld`
8. Wait for sidekiq to finished all the jobs
9. Navigate to `http://localhost:3000/users/possible_duplicate_emails?quick_calc=false`

# TODO
1. Implement error notification
2. Implement specs
3. Find more string matching algorithms

# Testing
1. Run `make test`

Warning: Currently using beta `gem 'rspec-rails', '~> 4.0.0.beta3'` due to bug listed here: https://stackoverflow.com/questions/58581334/generated-rspec-controller-test-is-failing-with-wrong-number-of-arguments-given

# Development Setup
```
rails new ruby-levenshtein-example --database=postgresql --skip-action-mailer --skip-action-mailbox
rake db:setup
rails generate rspec:install
rails g model users first_name:text last_name:text display_name:text email:text title:text ss_data:jsonb
rails g model similar_emails email_1:text email_2:text levenshtein_distance:integer damerau_levenshtein_distance:integer
```

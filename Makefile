.PHONY: $(MAKECMDGOALS)

setup:
	gem install bundler
	bundle install
	rake db:reset
	touch .env
	printf "API_ENDPOINT='XXXX'\nAPI_KEY='XXXX'\n" >> .env

server:
	rails s

test:
	rake db:reset RAILS_ENV=test
	rspec

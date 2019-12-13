.PHONY: $(MAKECMDGOALS)

setup:
	gem install bundler
	bundle install
	rake db:reset

server:
	rails s

test:
	rake db:reset RAILS_ENV=test
	rspec

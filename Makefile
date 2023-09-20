# Variables
DC := docker compose
DC_RUN := $(DC) run --rm
DC_RUN_APP := $(DC_RUN) app
DC_RUN_TEST := $(DC_RUN) test
DC_EXEC := $(DC) exec

# Common actions
.PHONY: up down build logs

up:
	$(DC) up -d

down:
	$(DC) down

build:
	$(DC) build

logs:
	$(DC) logs -f

# Application commands
.PHONY: bundle console server bash test test.session

bundle:
	$(DC_RUN_APP) bundle install
	$(DC_RUN_TEST) bundle install

console:
	$(DC_RUN_APP) bundle exec rails console

server:
	$(DC) up app

bash:
	$(DC_RUN_APP) bash

test:
	$(DC_RUN_TEST) bundle exec rspec

test.session:
	$(DC_RUN) test bash

# Database commands
.PHONY: db.setup db.migrate db.rollback db.reset db.seed db.session

db.setup:
	$(DC_RUN_APP) bin/rails db:drop db:setup

db.migrate:
	$(DC_RUN_APP) bin/rails db:migrate

db.rollback:
	$(DC_RUN_APP) bundle exec rails db:rollback STEP=$(STEP)

db.reset:
	$(DC_RUN_APP) bundle exec rails db:reset

db.seed:
	$(DC_RUN_APP) bundle exec rails db:seed

db.session:
	$(DC_RUN_APP) bundle exec rails db

# Commands for other services
.PHONY: pgadmin chrome redis

pgadmin:
	$(DC) up -d pgadmin

chrome:
	$(DC) up -d chrome

redis:
	$(DC) up -d redis

# Command to clean volumes
.PHONY: clean

clean:
	$(DC) down -v

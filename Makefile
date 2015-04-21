.PHONY: test

.DEFAULT_GOAL := test

bundle:
	bundle install

test:
	@rake

.PHONY: test

test:
	find ./ | entr sh -c "cd test; make test"

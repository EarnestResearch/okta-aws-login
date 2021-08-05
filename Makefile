default: test

build:
	stack build

test:
	stack test

clean:
	stack clean

build-linux-static:
	$$(nix-build --no-link -A fullBuildScript)

.PHONY: \
	build \
	clean \
	default \
	hoogle \
	lint \
	test \

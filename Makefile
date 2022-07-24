docker:
	nix-build
	docker load < ./result

test:
	poetry run pytest
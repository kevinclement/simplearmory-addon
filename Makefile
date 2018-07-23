archive:
	git archive HEAD --prefix=SimpleArmory --format=zip -o SimpleArmory-$(shell git describe).zip

.PHONY: archive

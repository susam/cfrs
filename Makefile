NAME = cfrs

checks: tidy lint

tidy:
	tidy -q -e --warn-proprietary-attributes no $(NAME).html

lint:
	npx standard --plugin html *.html

deps:
	npm install --no-save standard eslint-plugin-html
	if command -v brew; then brew install tidy-html5; fi

cc:
	git remote remove cc || :
	git remote add cc git@codeberg.org:susam/$(NAME).git
	git remote set-url cc --add git@github.com:susam/$(NAME).git
	git remote -v
	git push cc main

cp:
	cp $(NAME).html ~/git/susam.net/content/tree/

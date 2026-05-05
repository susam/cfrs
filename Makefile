NAME = cfrs

chk: tidy lint

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
	git remote remove origin || :
	git remote add origin "$$(git remote get-url cc)"
	git remote -v
	git push origin main
	git push cc main

cp:
	cp $(NAME).html ~/git/susam.net/content/tree/

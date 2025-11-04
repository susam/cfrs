APP = cfrs.html

checks: tidy lint

tidy:
	tidy -q -e --warn-proprietary-attributes no $(APP)

lint:
	npx standard --plugin html *.html

deps:
	npm install --no-save standard eslint-plugin-html
	if command -v brew; then brew install tidy-html5; fi

cp:
	cp $(APP) ~/git/susam.net/content/tree

pub: cp
	cd ~/git/susam.net/ && make copub

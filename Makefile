.PHONY: showcase
showcase:
	cd showcase && \
	elm-go \
		-d public \
		-- src/Main.elm \
		--output public/main.js

doc:
	elm-doc-preview \
		--output docs.json \
	&& elm-doc-preview \
		--no-browser \
		--port 8001

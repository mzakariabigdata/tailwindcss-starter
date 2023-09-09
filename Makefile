##########################
########## Vars ##########
##########################

.DEFAULT_GOAL := help 

PROJECT_NAME ?= "project-template"
HTML_PATH ?= $(PROJECT_NAME)/src/index.html
ASSETS_PATH ?=  $(PROJECT_NAME)/src/assets
DIST_PATH ?= $(PROJECT_NAME)/src/dist
CSS_DIST_PATH ?= $(DIST_PATH)/css
CSS_PATH ?= $(ASSETS_PATH)/css
IMG_PATH ?= $(ASSETS_PATH)/img

############################
# init tailwindcss project #
############################

init-install: ## install tailwindcss
	@echo "Installing tailwindcss..."
	npm init -y
	npm install tailwindcss postcss postcss-cli autoprefixer
	npx tailwindcss init -p

init-folders: ## create folders
	@echo "Creating folders..."
	mkdir -p $(CSS_DIST_PATH) $(IMG_PATH) $(CSS_PATH)
	touch $(HTML_PATH)

init-tailwind.css: init-folders ## init tailwindcss
	@echo "Creating tailwind.css..."
	echo "@import 'tailwindcss/base';" > $(CSS_PATH)/tailwind.css
	echo "@import 'tailwindcss/components';" >> $(CSS_PATH)/tailwind.css
	echo "@import 'tailwindcss/utilities';" >> $(CSS_PATH)/tailwind.css
	echo "@layer components { .custom-body { @apply bg-gradient-to-r from-green-500 to-red-700 flex justify-center items-center h-screen text-white; } }" >> $(CSS_PATH)/tailwind.css
	echo "@layer components { .custom-content { @apply p-8 bg-opacity-50 bg-gray-800 rounded-xl shadow-xl; } }" >> $(CSS_PATH)/tailwind.css

init-postcss.config: ## init postcss.config.js
	@echo "Creating postcss.config.js..."
	(echo "module.exports = {"; \
	echo "  plugins: ["; \
	echo "    require('tailwindcss'),"; \
	echo "    require('autoprefixer'),"; \
	echo "  ]"; \
	echo "};") > postcss.config.js

init-tailwind.config: ## init tailwind.config.js
	@echo "Creating tailwind.config.js..."
	(echo "/** @type {import('tailwindcss').Config} */"; \
	echo "module.exports = {"; \
	echo "  // files to scan for classes"; \
	echo "  content: ['./**/*.html', './**/*.js'],"; \
	echo "  theme: {"; \
	echo "    extend: {},"; \
	echo "  },"; \
	echo "  plugins: [],"; \
	echo "};" \
	) > tailwind.config.js

init-html: ## init index.html
	@echo "Creating index.html..."
	(echo "<!DOCTYPE html>"; \
	echo "<html lang=\"en\">"; \
	echo "<head>"; \
	echo "    <meta charset=\"UTF-8\">"; \
	echo "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"; \
	echo "    <title>$(PROJECT_NAME)</title>"; \
	echo "    <link rel=\"stylesheet\" href=\"./dist/css/style.css\">"; \
	echo "</head>"; \
	echo "<body class=\"custom-body\">"; \
	echo "    <div class=\"custom-content\">"; \
	echo "        <h1 class=\"text-5xl font-bold mb-4\">Hello World</h1>"; \
	echo "        <p class=\"text-xl\">Welcome to $(PROJECT_NAME) using Tailwind CSS!</p>"; \
	echo "    </div>"; \
	echo "</body>"; \
	echo "</html>"; \
	) > $(HTML_PATH)

add-scripts: ## add scripts to package.json
	@echo "Adding scripts to package.json..."
	@node -e "const fs = require('fs'); \
	          const path = './package.json'; \
	          const packageJson = JSON.parse(fs.readFileSync(path, 'utf8')); \
	          packageJson.scripts['build:css'] = 'postcss ./' + process.argv[1] + '/src/assets/css/tailwind.css -o ./' + process.argv[1] + '/src/dist/css/style.css'; \
	          packageJson.scripts['watch:css'] = 'postcss ./' + process.argv[1] + '/src/assets/css/tailwind.css -o ./' + process.argv[1] + '/src/dist/css/style.css -w'; \
	          fs.writeFileSync(path, JSON.stringify(packageJson, null, 2));" $(subst ",,$(PROJECT_NAME))


init-config: init-tailwind.config init-postcss.config ## init config files

post-config: init-html add-scripts ## add scripts to package.json

watch: ## watch css
	@echo "Watching css..."
	npm run watch:css

init: init-install init-tailwind.css init-config post-config ## init tailwindcss project
	@echo "Init done!"
	npx tailwindcss build $(CSS_PATH)/tailwind.css -o $(CSS_DIST_PATH)/style.css

tailwindcss-starter: init ## Initializes a new TailwindCSS project with a specified or default project name.

purge: ## Remove generated files and caches
	@echo "Purging generated files and caches..."
	rm -rf $(CSS_DIST_PATH)/*   # Removes generated CSS files
	rm -rf .cache   # Removes cache if you're using tools like Parcel
	@echo "Purge complete!"

clean: ## delete all files and folders
	@echo "Deleting all files and folders..."
	find . ! -path './.git/*' ! -name 'Makefile' ! -name 'README*' ! -name '.git*' -type f -exec rm -f {} +
	find . ! -path './.git/*' ! -name '.' ! -name '.git' -type d -exec rm -rf {} +

.PHONY: init init-install init-folders init-tailwind.css init-postcss.config init-tailwind.config init-html add-scripts init-config post-config tailwindcss-starter clean

##########################
########## Help ##########
##########################

help: ## Display this help
	@echo ""
	@echo "Example of usage:"
	@echo "  make tailwindcss-starter PROJECT_NAME=my_new_project"
	@echo ""
	@echo "All commands:"
	@echo ""
	@grep -E '^[a-zA-Z0-9_-]+:.*?# .*$$' Makefile | sort | awk -F':.*?# ' '/^[a-zA-Z0-9_-]+:.*?#/ {printf "  make \033[36m%-16s\033[0m %s\n", $$1, $$2}'

.PHONY: help

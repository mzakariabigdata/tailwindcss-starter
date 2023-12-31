# TailwindCSS Starter

Easily bootstrap a new TailwindCSS project with this Makefile driven setup.

## Getting Started

1. Ensure you have [npm](https://www.npmjs.com/get-npm) installed.
2. Clone this repository or use it as a template on GitHub.
3. Navigate to the project directory.
4. Run `make tailwindcss-starter` to set up a new TailwindCSS project.

### Specifying a Project Name

If you wish to specify a custom name for your project, you can do so using the `PROJECT_NAME` argument. For example:

```
make tailwindcss-starter PROJECT_NAME=CARD
```

This will initialize the project with the name "CARD" instead of the default "project-template".

## Features

- Automated TailwindCSS setup.
- Pre-configured folder structure.
- Automated HTML file generation with basic TailwindCSS styles.
- PostCSS and TailwindCSS configuration out of the box.
- npm scripts for building and watching CSS.

## Directory Structure

- **src**: This is where your source files reside.
    - **assets**: Assets directory containing CSS and images.
    - **dist**: Distribution directory where the compiled CSS will be placed.

## Make Commands

- `make tailwindcss-starter`: Initializes a new TailwindCSS project.
- `make purge`: Remove generated files and caches.
- `make init-install`: Installs required npm packages.
- `make init-folders`: Sets up the required directory structure.
- `make init-tailwind.css`: Creates the main TailwindCSS file with some custom styles.
- `make init-postcss.config`: Generates the PostCSS configuration file.
- `make init-tailwind.config`: Generates the Tailwind configuration file.
- `make init-html`: Produces a basic HTML file referencing the TailwindCSS styles.
- `make add-scripts`: Adds build and watch scripts to the `package.json` file.
- `make watch`: Watches for changes in the CSS and compiles them.
- `make clean`: Removes all generated files and directories, excluding the Makefile.

For a complete list of commands and their descriptions, run `make help`.

## Contribution

If you have ideas or improvements, feel free to make a pull request!

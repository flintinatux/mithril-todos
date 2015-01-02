# Mithril Todos

Sample todos app built on [Mithril](https://lhorie.github.io/mithril/index.html) and [Express](http://expressjs.com/).  Uses [localforage](http://mozilla.github.io/localForage/) for client-side storage, and [Sortable](http://rubaxa.github.io/Sortable/) to make it reorderable without jQuery.

<!-- MarkdownTOC -->

- [Installation](#installation)
- [Dev setup](#dev-setup)
- [Prod setup](#prod-setup)

<!-- /MarkdownTOC -->

## Installation

Just clone and run:

```
> npm install -g bower
> npm install
> bower install
```

## Dev setup

Start the server with:

```
> npm start
```

Then watch your files and rebuild the client on the fly:

```
> npm run watch
```

## Prod setup

Get your client assets ready for production with:

```
> npm run build
```

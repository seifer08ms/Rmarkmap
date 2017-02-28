# R Interface to markmap library
Create Interactive Web MindMap with the JavaScript 'markmap' Library

[markmap](https://github.com/dundalek/markmap) is an open-source JavaScript library to visualize markdown documents as a interactive mindmap. This R package makes it easy to create markmap from R.

## Installation

You can install this package from Github:

```r
if (!require('devtools')) install.packages('devtools')
devtools::install_github('seifer08ms/rmarkmap')
```
## Usage

### Built-in Theme

get started with a default theme:

```r
library(markmap)
md <- system.file('examples/test.md',package = 'Rmarkdown')
markmap(md) # a markmap with the default theme
```
create a markmap with the colorful theme:

```r
markmap(md,options = markmapOption(preset='colorful')) # a markmap with the colorful theme
```

### More Options about markmap
```r
# using d3.scale.category20b() and bracker linkShape
markmap(md,options = markmapOption(color='category20b',linkShape='bracket'))

# using d3.scale.category20b() basic rendered and diagonal linkShape
markmap(md,options = markmapOption(color='category20b',linkShape='diagonal',renderer = 'basic'))
```

## License

This package is licensed to you under the terms of the [GNU General Public
License](http://www.gnu.org/licenses/gpl.html) version 3 or later.

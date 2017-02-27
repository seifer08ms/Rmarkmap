#' @title Create a markmap widget
#'
#' @description This function creates a markmap widget using htmlwidgets.The widget can be rendered on HTML pages generated from R Markdown,Shiny,or other applications.
#' Options for markmap creation#'
#'
#' @import htmlwidgets
#' @examples
#' gtor.json<-system.file('examples/gtor.json',package = 'Rmarkmap')
#' markmap(gtor.json)
#' @export
markmap <- function(json, width = NULL, height = NULL, elementId = NULL,options=NULL) {

    data<-paste(readLines(json),collapse = '\n')
    # forward options using x
    x = list(
        data = data
    )


  # create widget
  htmlwidgets::createWidget(
    name = 'markmap',
    x,
    width = width,
    height = height,
    package = 'Rmarkmap',
    elementId = elementId
  )
}

#' Shiny bindings for markmap
#'
#' Output and render functions for using markmap within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a markmap
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name markmap-shiny
#'
#' @export
markmapOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'markmap', width, height, package = 'Rmarkmap')
}

#' @rdname markmap-shiny
#' @export
renderMarkmap <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, markmapOutput, env, quoted = TRUE)
}

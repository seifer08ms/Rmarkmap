#' Create a markmap widget
#'
#' This function creates a markmap widget using htmlwidgets.
#' The widget can be rendered on HTML pages generated from
#' R Markdown,Shiny,or other applications.
#' @param path the path of markdown file
#' @param width the width of the markmap
#' @param height the height of the markmap
#' @param options the markmap options
#' @import htmlwidgets
#' @return A HTML widget object rendered from a given document.
#' @examples
#' md<-system.file('examples/test.md',package = 'Rmarkmap')
#' markmap(md)
#' @export
markmap <- function(path, width = NULL, height = NULL, elementId = NULL,options=markmapOption()) {

    data<-paste(readLines(path),collapse = '\n')
    # forward options using x
    x = list(
        data = data,
        options = options
    )


  # create widget
  htmlwidgets::createWidget(
    name = 'markmap',
    x,
    width = width,
    height = height,
    sizingPolicy = htmlwidgets::sizingPolicy(
        defaultWidth = '100%',
        defaultHeight = 400,
        padding = 0,
        browser.fill = TRUE
    ),
    package = 'Rmarkmap',
    elementId = elementId
  )
}
#' Options for markmap creation
#' @param preset the name of built-in theme for markmap. If present, any other parameters will be ignored.
#' @param nodeHeight the height of nodes in the markmap.
#' @param nodeWidth the width of nodes in the markmap.
#' @param spacingVertical space of vertical.
#' @param spacingHorizontal space of horizontal.
#' @param duration duration time for animation.
#' @param layout layout mode of makrmap. Currently, only 'tree' is accepted.
#' @param color color of markmap. A character color value ,either 'gray' or
#' a categorical colors including 'category10','category20','category20b' and 'category20c'.
#' @param linkShape link shape of markmap. A character value, either 'diagonal' or 'bracket'.
#' @param renderer rendered shaped of markmap. A character value ,either 'basic' or 'boxed'.
#' @param ... other options.
#' @describeIn theme Options for markmap creation
#' @details Currently,markmap have 'default' and 'colorful' themes.
#' 'colorful' themes have three different parameters from default themes:
#'  {nodeHeight: 10, renderer: 'basic',color: 'category20'}
#' @seealso \url{https://github.com/dundalek/markmap/blob/master/view.mindmap.js} for details.
#' @examples
#' md<-system.file('examples/test.md',package = 'Rmarkmap')
#' markmap(md,options = markmapOption(preset = 'colorful')) # 'colorful' theme
#'
#' # more options for self-defined markmap
#' markmap(md,options = markmapOption(color='category20b',linkShape='bracket'))
#'
#' markmap(md,options = markmapOption(color='category20b',linkShape='diagonal',renderer = 'basic'))
#' @export
markmapOption <- function(preset=NULL,nodeHeight=20,
                          nodeWidth=180,
                          spacingVertical=10,
                          spacingHorizontal=120,
                          duration=750,
                          layout='tree',
                          color='gray',#
                          linkShape='diagonal',
                          renderer='boxed',...){
    filterNULL<-function (x) {
        if (length(x) == 0 || !is.list(x))
            return(x)
        x[!unlist(lapply(x, is.null))]
    }
    if(!is.null(preset)&&(preset=='default'|preset=='colorful')){
        filterNULL(list(preset=preset))
    }else{
        if (is.null(layout)||(layout!='tree')){
            warning('Currenly, only tree layout is supported. Changing to tree layout...')
            layout = 'tree'
        }
        filterNULL(list(nodeHeight=nodeHeight,
                        nodeWidth=nodeWidth,
                        spacingVertical=spacingVertical,
                        spacingHorizontal=spacingHorizontal,
                        duration=duration,
                        layout='tree',
                        color=color,
                        linkShape=linkShape,
                        renderer=renderer,...))
    }

}
#'
#'
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
#' #'
#' @rdname markmap-shiny
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

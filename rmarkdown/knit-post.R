#' Knit a post for the blog
#'
knit_post <- function(rmd.file, date = Sys.time()) {
  rmd.name <- tools::file_path_sans_ext(rmd.file)
  posts.path <- file.path('..', '_posts')
  fig.dir <- file.path(posts.path, '..', 'images', 'R-figs/')
  knitr::render_jekyll(highlight = "pygments")
  knitr::opts_knit$set(base.url = '/', base.dir = posts.path)
  knitr::opts_chunk$set(fig.path = fig.dir, fig.width = 8.5, fig.height = 5.25, dev = 'svg', cache = F,
                        warning = F, message = F, cache.path = '_cache/', tidy = F)
  today <- format(date, "%Y-%m-%d")
  #
  # Get the output file name correct, it must start with the hyphenated date
  out.file <- file.path(posts.path, stringr::str_c(today, '-', rmd.name, '.md'))
  knitr::knit(rmd.file, output = out.file, envir = parent.frame(), quiet = F)
}

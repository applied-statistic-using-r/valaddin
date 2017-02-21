# Call signature of a function (specified by name)
call_sig <- function(x, ...) {
  stopifnot(is.character(x))

  call_sig_ <- function(nm) {
    f <- get(nm, mode = "function", ...)
    sig_raw <- deparse(call("function", formals(f), quote(expr = )))
    sig <- paste(trimws(sig_raw, which = "left"), collapse = "")

    sub("^function", nm, trimws(sig, which = "both"))
  }

  vapply(x, call_sig_, FUN.VALUE = character(1), USE.NAMES = FALSE)
}

# Convert a string-valued function into a vectorized function that joins strings
vec_strjoin <- function(f_str, join = "\n") {
  force(f_str)
  force(join)

  function(x)
    paste(vapply(x, f_str, character(1)), collapse = join)
}

# Make a function that makes raw Rd tags
rd_markup <- function(cmd, join = "", sep = "") {
  force(join)
  force(sep)
  cmd_opening <- paste0("\\", cmd, "{")

  function(x) {
    stopifnot(is.character(x))
    paste(cmd_opening, paste(x, collapse = join), "}", sep = sep)
  }
}

#' Make a raw Rd markup
#'
#' @param x Character vector of object names.
#' @name rd_markup
#' @noRd
NULL

#' @rdname rd_markup
#' @param ... Arguments to pass to \code{\link[base]{get}}.
#' @examples
#' rd_usage("ls")
#' rd_usage(c("strictly", "nonstrictly"), pos = "package:valaddin")
#' @noRd
rd_usage <- purrr::compose(rd_markup("usage", join = "\n\n", sep = "\n"), call_sig)

#' @rdname rd_markup
#' @examples
#' rd_alias(c("strictly", "nonstrictly"))
#' @noRd
rd_alias <- vec_strjoin(rd_markup("alias"))
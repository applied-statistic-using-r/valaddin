# Call signature of a function (specified by name)
call_sig <- function(x, ...) {
  stopifnot(is.character(x))
  is_op <- grepl("^%.+%$", x)
  x[ is_op] <- vapply(x[ is_op], call_sig_op, character(1), USE.NAMES = FALSE)
  x[!is_op] <- vapply(x[!is_op], call_sig_fn, character(1), USE.NAMES = FALSE)
  x
}

call_sig_fn <- function(nm) {
  f <- get(nm, mode = "function")
  sig_raw <- deparse(call("function", formals(f), quote(expr = )))
  sig <- paste(trimws(sig_raw, which = "left"), collapse = "")
  sub("^function", nm, trimws(sig, which = "both"))
}

call_sig_op <- function(nm) {
  op <- get(nm, mode = "function")
  args <- names(formals(op))
  nm_esc_pct <- gsub("%", "\\\\%", nm)
  paste(args[1L], nm_esc_pct, args[2L])
}

# Convert a string-valued function into a vectorized function that joins strings
vec_strjoin <- function(f_str, join = "\n") {
  force(f_str)
  force(join)

  function(x)
    paste(vapply(x, f_str, character(1)), collapse = join)
}

# Make a function that makes raw Rd markup
rd_markup <- function(cmd, join = "", sep = "") {
  force(join)
  force(sep)
  cmd_opening <- paste0("\\", cmd, "{")

  function(x) {
    stopifnot(is.character(x))
    paste(cmd_opening, paste(x, collapse = join), "}", sep = sep)
  }
}

#' Make raw Rd markup
#'
#' @param x Character vector of object names.
#' @name rd_markup
#' @noRd
NULL

#' @rdname rd_markup
#' @examples
#' rd_alias(c("firmly", "loosely"))
#' @noRd
rd_alias <- vec_strjoin(rd_markup("alias"))

#' @rdname rd_markup
#' @param \dots Arguments to pass to \code{\link[base]{get}}.
#' @examples
#' rd_usage("ls")
#' rd_usage(c("firmly", "loosely"), pos = "package:valaddin")
#' @noRd
rd_usage <- purrr::compose(rd_markup("usage", join = "\n\n", sep = "\n"), call_sig)

#' @rdname rd_markup
#' @examples
#' rd_seealso("Logarithm: \\code{\\link{log}}, \\code{\\link[utils]{head}}")
#' @noRd
rd_seealso <- rd_markup("seealso", join = "\n\n", sep = "\n")

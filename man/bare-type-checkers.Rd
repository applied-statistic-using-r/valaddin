% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checkers.R
\name{bare-type-checkers}
\alias{bare-type-checkers}
\title{Bare type checkers}
\arguments{
\item{\dots}{One-sided formulae that specify the expressions to check.}
}
\value{
Check formula of local scope.
}
\description{
These functions make check formulae of local scope based on the
correspondingly named \link[purrr:bare-type-predicates]{bare type predicate}
from the \pkg{purrr} package. For example, \code{vld_bare_atomic()} creates
check formulae (of local scope) for the \pkg{purrr} predicate function
\code{\link[purrr]{is_bare_atomic}()}.
}
\details{
Each function \code{vld_*()} is a function of class
  \code{"check_maker"} generated by \code{\link{localize}()}.
}
\examples{
\dontrun{

f <- function(x, y) "Pass"

# Impose a check on x: ensure it's a bare logical object (i.e., has no class)
f_strict <- strictly(f, vld_bare_logical(~ x))
x <- structure(TRUE, class = "boolean")
f_strict(TRUE, 0)  # "Pass"
f_strict(x, 0)     # Error: "Not bare logical: x"

# To impose the same check on all arguments, apply globalize()
f_stricter <- strictly(f, globalize(vld_bare_logical))
f_stricter(TRUE, FALSE)  # "Pass"
f_stricter(TRUE, 0)      # Error: "Not bare logical: y"
f_stricter(x, 0)         # Errors: "Not bare logical: x", "Not bare logical: y"
}
}
\alias{vld_bare_atomic}
\alias{vld_bare_character}
\alias{vld_bare_double}
\alias{vld_bare_integer}
\alias{vld_bare_list}
\alias{vld_bare_logical}
\alias{vld_bare_numeric}
\alias{vld_bare_vector}
\usage{
vld_bare_atomic(...)

vld_bare_character(...)

vld_bare_double(...)

vld_bare_integer(...)

vld_bare_list(...)

vld_bare_logical(...)

vld_bare_numeric(...)

vld_bare_vector(...)
}
\seealso{
Corresponding predicates: \link[purrr:bare-type-predicates]{Bare type predicates} (\pkg{purrr})

\code{\link{globalize}()} recovers the underlying check formula of global scope.

 The documentation for \code{\link{strictly}()} explains the notion of \dQuote{scope} in the context of check formulae.

Other checkers: \code{\link{misc-checkers}}, \code{\link{scalar-type-checkers}}, \code{\link{type-checkers}}
}
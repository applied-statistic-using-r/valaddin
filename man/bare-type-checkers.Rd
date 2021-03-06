% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checkers.R
\name{bare-type-checkers}
\alias{bare-type-checkers}
\title{Bare type checkers}
\arguments{
\item{\dots}{Check items, i.e., formulae that are one-sided or have a string
as left-hand side (see \emph{Check Formulae of Local Scope} in the
documentation page \link{firmly}). These are the expressions to check.}
}
\value{
Check formula of local scope.
}
\description{
These functions make check formulae of local scope based on the
correspondingly named \link[purrr:bare-type-predicates]{bare type predicate}
from the
\href{https://cran.r-project.org/package=purrr}{\pkg{purrr}}
package. For example, \code{vld_bare_atomic} creates check formulae (of
local scope) for the \pkg{purrr} predicate function
\code{\link[purrr]{is_bare_atomic}}.
}
\details{
Each function \code{vld_*} is a function of class
  \code{"check_maker"}, generated by \code{\link{localize}}.
}
\examples{
\dontrun{

f <- function(x, y) "Pass"

# Impose a check on x: ensure it's a bare logical object (i.e., has no class)
f_firm <- firmly(f, vld_bare_logical(~x))
x <- structure(TRUE, class = "boolean")
f_firm(TRUE, 0)  # [1] "Pass"
f_firm(x, 0)     # Error: "Not bare logical: x"

# Use a custom error message
msg <- "x should be a logical vector without attributes"
f_firm <- firmly(f, vld_bare_logical(msg ~ x))
f_firm(x, 0)     # Error: "x should be a logical vector without attributes"

# To impose the same check on all arguments, apply globalize()
f_firmer <- firmly(f, globalize(vld_bare_logical))
f_firmer(TRUE, FALSE)  # [1] "Pass"
f_firmer(TRUE, 0)      # Error: "Not bare logical: `y`"
f_firmer(x, 0)         # Errors: "Not bare logical: `x`", "Not bare logical: `y`"
}
}
\alias{vld_bare_atomic}
\alias{vld_bare_character}
\alias{vld_bare_double}
\alias{vld_bare_integer}
\alias{vld_bare_list}
\alias{vld_bare_logical}
\alias{vld_bare_vector}
\usage{
vld_bare_atomic(...)

vld_bare_character(...)

vld_bare_double(...)

vld_bare_integer(...)

vld_bare_list(...)

vld_bare_logical(...)

vld_bare_vector(...)
}
\seealso{
Corresponding predicates: \link[purrr:bare-type-predicates]{Bare type predicates} (\href{https://cran.r-project.org/package=purrr}{\pkg{purrr}})

\code{\link{globalize}} recovers the underlying check formula of global scope.

The notions of \dQuote{scope} and \dQuote{check item} are explained in the \emph{Check Formulae} section of \link{firmly}.

Other checkers: \link{misc-checkers}, \link{scalar-type-checkers}, \link{type-checkers}
}

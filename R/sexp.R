#' Duplicate an R object
#'
#' In R semantics, objects are copied by value. This means that
#' modifying the copy leaves the original object intact. Since,
#' copying data in memory is an expensive operation, copies in R are
#' as lazy as possible. They only happen when the new object is
#' actually modified. However, some operations (like [node_poke_car()]
#' or [node_poke_cdr()]) do not support copy-on-write. In those cases,
#' it is necessary to duplicate the object manually in order to
#' preserve copy-by-value semantics.
#'
#' Some objects are not duplicable, like symbols and environments.
#' `duplicate()` returns its input for these unique objects.
#'
#' @param x Any R object. However, uncopyable types like symbols and
#'   environments are returned as is (just like with `<-`).
#' @param shallow This is relevant for recursive data structures like
#'   lists, calls and pairlists. A shallow copy only duplicates the
#'   top-level data structure. The objects contained in the list are
#'   still the same.
#' @seealso pairlist
#' @keywords internal
#' @export
duplicate <- function(x, shallow = FALSE) {
  .Call(rlang_duplicate, x, shallow)
}


# nocov start - These functions are mostly for interactive experimentation

poke_type <- function(x, type) {
  invisible(.Call(rlang_poke_type, x, type))
}
sxp_address <- function(x) {
  .Call(rlang_sxp_address, x)
}

mark_object <- function(x) {
  invisible(.Call(rlang_mark_object, x))
}
unmark_object <- function(x) {
  invisible(.Call(rlang_unmark_object, x))
}

true_length <- function(x) {
  .Call(rlang_true_length, x)
}
env_frame <- function(x) {
  .Call(rlang_env_frame, x)
}
env_hash_table <- function(x) {
  .Call(rlang_env_hash_table, x)
}

# nocov end

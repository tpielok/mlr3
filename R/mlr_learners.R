#' @title Dictionary of Learners
#'
#' @usage NULL
#' @format [R6::R6Class] object inheriting from [mlr3misc::Dictionary].
#'
#' @description
#' A simple [mlr3misc::Dictionary] storing objects of class [Learner].
#' Each learner has an associated help page, see `mlr_learners_[id]`.
#'
#' This dictionary can get populated with additional learners by add-on packages.
#' For more classification and regression learners, load the \CRANpkg{mlr3learners} package
#' and \url{https://github.com/mlr3learners}.
#'
#' For a more convenient way to retrieve and construct learners, see [lrn()]/[lrns()].
#'
#' @section Methods:
#' See [mlr3misc::Dictionary].
#'
#' @section S3 methods:
#' * `as.data.table(dict)`\cr
#'   [mlr3misc::Dictionary] -> [data.table::data.table()]\cr
#'   Returns a [data.table::data.table()] with fields "key", "feature_types", "packages",
#'   "properties" and "predict_types" as columns.
#'
#' @family Dictionary
#' @family Learner
#' @seealso
#' Sugar functions: [lrn()], [lrns()]
#'
#' Extension Packages: \CRANpkg{mlr3learners}
#' @export
#' @examples
#' as.data.table(mlr_learners)
#' mlr_learners$get("classif.featureless")
#' lrn("classif.rpart")
mlr_learners = R6Class("DictionaryLearner",
  inherit = Dictionary,
  cloneable = FALSE,
)$new()

#' @export
as.data.table.DictionaryLearner = function(x, ...) {
  setkeyv(map_dtr(x$keys(), function(key) {
    l = x$get(key)
    list(
      key = key,
      feature_types = list(l$feature_types),
      packages = list(l$packages),
      properties = list(l$properties),
      predict_types = list(l$predict_types)
    )
  }), "key")[]
}

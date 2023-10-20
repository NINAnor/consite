#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import dplyr
#' @import sf
#' @import stringi
#' @import DT
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  # for testing, read in a dummy csv file (DB connection)

  mod_define_study_area_server("study_area")
  mod_explore_studies_server("explore_studies")

}

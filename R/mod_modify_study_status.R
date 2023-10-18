#' modify_study_status UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_modify_study_status_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' modify_study_status Server Functions
#'
#' @noRd 
mod_modify_study_status_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_modify_study_status_ui("modify_study_status_1")
    
## To be copied in the server
# mod_modify_study_status_server("modify_study_status_1")

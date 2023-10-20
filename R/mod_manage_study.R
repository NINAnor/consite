#' manage_study UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_manage_study_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' manage_study Server Functions
#'
#' @noRd 
mod_manage_study_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_manage_study_ui("manage_study_1")
    
## To be copied in the server
# mod_manage_study_server("manage_study_1")

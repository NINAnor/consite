#' define_study_area UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_define_study_area_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' define_study_area Server Functions
#'
#' @noRd 
mod_define_study_area_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_define_study_area_ui("define_study_area_1")
    
## To be copied in the server
# mod_define_study_area_server("define_study_area_1")

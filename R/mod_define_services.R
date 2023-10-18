#' define_services UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_define_services_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' define_services Server Functions
#'
#' @noRd 
mod_define_services_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_define_services_ui("define_services_1")
    
## To be copied in the server
# mod_define_services_server("define_services_1")

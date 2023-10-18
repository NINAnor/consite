#' invite_participants UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_invite_participants_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' invite_participants Server Functions
#'
#' @noRd 
mod_invite_participants_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_invite_participants_ui("invite_participants_1")
    
## To be copied in the server
# mod_invite_participants_server("invite_participants_1")

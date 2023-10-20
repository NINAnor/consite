#' explore_studies UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_explore_studies_ui <- function(id){
  ns <- NS(id)
  tagList(
    textInput(ns("proj_id"),"provide the proj id"),
    actionButton(ns("sub1"),"explore project")
  )
}

#' explore_studies Server Functions
#'
#' @noRd
mod_explore_studies_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    study_area<-read.csv("C:/Users/reto.spielhofer/OneDrive - NINA/Documents/Projects/GEOPROSPECTIVE/admin_app/studyarea.csv")

    ## as soon as study ID is provided, there will be KPIs regarding the actual state of the study and the number of participants per ES
    observeEvent(input$sub1,{
      # study_area<-study_area()
        insertUI(selector = paste0("#",ns("sub1")),
                 where = "afterEnd",
                 ui=tagList(
                   textOutput(ns("status1"))
                 )

        )
      if(input$proj_id %in% study_area$studyareaID){
        status<-study_area%>%filter(studyareaID==input$proj_id)%>%select(areaStatus)

        output$status1<-renderText(paste0("The project has status  ", as.numeric(status)))

      }else{
        output$status1<-renderText(paste0("This project does not exist"))
      }

    })


  })
}

## To be copied in the UI
# mod_explore_studies_ui("explore_studies_1")

## To be copied in the server
# mod_explore_studies_server("explore_studies_1")

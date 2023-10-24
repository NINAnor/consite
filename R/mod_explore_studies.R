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
    h5("Here you can explore the project status"),
    br(),
    textInput(ns("proj_id"),"provide the project id"),
    br(),
    actionButton(ns("sub1"),"explore project")
  )
}

#' explore_studies Server Functions
#'
#' @noRd
mod_explore_studies_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    projects<-readRDS("C:/Users/reto.spielhofer/OneDrive - NINA/Documents/Projects/GEOPROSPECTIVE/admin_app/projects.rds")

    ## as soon as study ID is provided, there will be KPIs regarding the actual state of the study and the number of participants per ES
    observeEvent(input$sub1,{
      # study_area<-study_area()
        insertUI(selector = paste0("#",ns("sub1")),
                 where = "afterEnd",
                 ui=tagList(
                   textOutput(ns("status1")),
                   br(),
                   textOutput(ns("status2"))
                 )

        )
      if(input$proj_id %in% projects$projID){
        status<-projects%>%filter(projID==input$proj_id)%>%select(projStatus)
        study_geom<-readRDS("C:/Users/reto.spielhofer/OneDrive - NINA/Documents/Projects/GEOPROSPECTIVE/admin_app/study_geom/study_geom.rds")
        n_study_areas<-nrow(study_geom%>%filter(projID==input$proj_id)%>%distinct(studyID))


        output$status1<-renderText(paste0("The project has status  ", as.numeric(status)))
        output$status2<-renderText(paste0("There are  ", as.numeric(n_study_areas), " active study areas in this project"))

        ## here N of participants per ES can be visualized

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

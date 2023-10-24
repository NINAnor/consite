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
    h5(" here you can open and close the current studies"),
    br(),
    textInput(ns("proj_id"),"Which project ID you want to modify?"),
    actionButton(ns("conf"),"confirm the project to be modified")

  )
}

#' manage_study Server Functions
#'
#' @noRd
mod_manage_study_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    projects<-readRDS("C:/Users/reto.spielhofer/OneDrive - NINA/Documents/Projects/GEOPROSPECTIVE/admin_app/projects.rds")


    observeEvent(input$conf,{
    if(input$proj_id %in% projects$projID){
     projstatus<-as.numeric(projects%>%filter(projID==input$proj_id)%>%select(projStatus))
    }else{
     projstatus = NULL
    }

    if(projstatus == "1"){

        insertUI(selector = paste0("#",ns("conf")),
                 where = "afterEnd",
                 ui=tagList(
                   h5("The project runs Delphi R 1, close the first Delphi round"),
                   br(),
                   actionButton(ns("closeR1"),"close round 1")

                 )
        )


    }else if(projstatus=="2"){

        insertUI(selector = paste0("#",ns("conf")),
                 where = "afterEnd",
                 ui=tagList(
                   h5("The project R1 is closed, open a R2"),
                   br(),
                   actionButton(ns("openR2"),"open round 2")

                 )
        )


    }else if(projstatus == "3"){

        insertUI(selector = paste0("#",ns("conf")),
                 where = "afterEnd",
                 ui=tagList(
                   h5("The project R2 is running, close R2"),
                   br(),
                   actionButton(ns("closeR2"),"close round 2")

                 )
        )


    }else if(projstatus == "4"){

        insertUI(selector = paste0("#",ns("conf")),
                 where = "afterEnd",
                 ui=tagList(
                   h5("Both rounds of the projects are compleated"))


        )

    }else {

        insertUI(selector = paste0("#",ns("conf")),
                 where = "afterEnd",
                 ui=tagList(
                   h5("Project not found"))


        )

    }
      })

  })

  ### server logic for "closeR1"
  ## the ind maps R1 of the gee projectID have to be merged per ES and per studyID -- CV map
  ## status of projects should be set to 2

  ### server logic for "openR2"
  ## the status of the DB should be changed to 3

  ### server logic for "closeR2"
  ## the ind maps R2 of the gee projectID have to be merged per ES and per studyID -- CV map
  ## status of projects should be set to 4

}

## To be copied in the UI
# mod_manage_study_ui("manage_study_1")

## To be copied in the server
# mod_manage_study_server("manage_study_1")

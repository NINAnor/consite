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
        textInput(ns("proj_id"),"provide the proj id"),
        actionButton(ns("sub1"),"create new study in the project"),
        br()
  )
}

#' define_study_area Server Functions
#'
#' @noRd
mod_define_study_area_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    ## read in the base dat (not after with db)
    # study_area<-read.csv("C:/Users/reto.spielhofer/OneDrive - NINA/Documents/Projects/GEOPROSPECTIVE/admin_app/studyarea.csv")

    projID<-eventReactive(input$sub1,{
      projID<-stri_rand_strings(1, 10, pattern = "[A-Za-z0-9]")
    })

    observeEvent(input$sub1,{
      ## here create a new UID for the study area
      ## show the shp reader and the map output
      insertUI(selector =paste0("#",ns("sub1")),
               where = "afterEnd",
               ui=tagList(
                 fileInput(ns("filemap"), "", accept=c('.shp','.dbf','.sbn','.sbx','.shx',".prj"), multiple=TRUE),
                 br(),
                 plotOutput(ns("mapview")),
                 br(),
                 actionButton(ns("sub2"),"upload study area to server")
               )
      )
    })

    observeEvent(input$sub2,{
      insertUI(selector = paste0("#",ns("sub2")),
               where = "afterEnd",
               ui=tagList(
                 h5("the description of the csv file"),
                 br(),
                 fileInput(ns("es_file"),"",accept = ".csv"),
                 br(),
                 DTOutput(ns("es_table_out"))

               )
               )
    })
    ## upload the table
    observe({
      projID<-projID()
      dt<-input$es_file
      if(is.null(dt)){
        return()
      }
      es_data<-read.csv(dt$datapath)
      es_data$projID<-rep(projID,nrow(es_data))
      output$es_table_out<-renderDT(
        es_data
      )
    })


    ## upload the shp and attach uid
    observe({
      projID<-projID()
      shpdf <- input$filemap
      if(is.null(shpdf)){
        return()
      }
      previouswd <- getwd()
      uploaddirectory <- dirname(shpdf$datapath[1])
      setwd(uploaddirectory)
      for(i in 1:nrow(shpdf)){
        file.rename(shpdf$datapath[i], shpdf$name[i])
      }
      setwd(previouswd)

      map <- sf::st_read(paste(uploaddirectory, shpdf$name[grep(pattern="*.shp$", shpdf$name)], sep="/"))#,  delete_null_obj=TRUE)
      map <- sf::st_transform(map, 4326)
      map$studyregID<-rep(projID,nrow(map))

      ## store the sf object and the project key in the bq

      ## plot it
      output$mapview<-renderPlot({
        plot(map)
      })


    })

    ## upload csv table



    # observeEvent(input$b2,{
    #   # checkproject credentials
    #
    #   if(input$proj_id %in% study_area$projID & input$area_id %in% study_area$studyareaID){
    #     status<-study_area%>%filter(projID==input$proj_id)%>%select(areaStatus)
    #     output$status1<-renderText("the project is available")
    #     output$cond_ui1<-renderUI({
    #       # br()
    #       paste0("The current status of the project is: ",status)
    #       actionButton(ns("close"),"close current delphi round")
    #       # conditionalPanel(condition = "status == 1",
    #       #
    #
    #
    #     })
    #   }else{
    #     output$status1<-renderText("The project and study area is not available")
    #   }
    #
    # })
    #
    # observeEvent(input$close,{
    #   study_area_sel<-study_area%>%filter(projID==input$proj_id)
    #   if(study_area_sel$areaStatus == 1){
    #     ## write proj status == 2 in table and save so that user app will not open R1 further
    #     print(" Round one of your project will be closed, and the CV raster per ES calculated")
    #     ## merge all ee_rasters with input$studyareaID and calculate CV raster per ES -->
    #
    #
    #   }else if(study_area_sel$areaStatus == 2){
    #     ## write proj status == 3 in table and save so that user app will not open R2 further
    #     print(" Round two of your project will be closed, and the CV raster per ES calculated")
    #     ## merge all ee_rasters with input$studyareaID and calculate CV raster per ES -->
    #   }
    #
    # })



  })
}

## To be copied in the UI
# mod_define_study_area_ui("define_study_area_1")

## To be copied in the server
# mod_define_study_area_server("define_study_area_1")

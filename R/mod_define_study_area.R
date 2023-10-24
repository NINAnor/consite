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
        h5("You need a 8 digit project ID to create different case study areas for the project"),
        textInput(ns("proj_id"),"provide the proj id"),
        actionButton(ns("check_proj"),"check project"),
        br()
  )
}

#' define_study_area Server Functions
#'
#' @noRd
mod_define_study_area_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    ### load the data (local so far)
    projects<-readRDS("C:/Users/reto.spielhofer/OneDrive - NINA/Documents/Projects/GEOPROSPECTIVE/admin_app/projects.rds")
    study_geom<-readRDS("C:/Users/reto.spielhofer/OneDrive - NINA/Documents/Projects/GEOPROSPECTIVE/admin_app/study_geom/study_geom.rds")
    es_in<-readRDS("C:/Users/reto.spielhofer/OneDrive - NINA/Documents/Projects/GEOPROSPECTIVE/admin_app/es.rds")

    observeEvent(input$check_proj,{
      if(input$proj_id %in% projects$projID){
        insertUI(selector =paste0("#",ns("check_proj")),
                 where = "afterEnd",
                 ui=tagList(
                   textInput(ns("stud_name"),"Name of case study area"),
                   br(),
                   textInput(ns("stud_descr"), "Description of case study area"),
                   br(),
                   h5("upload shp file of study area extent"),
                   fileInput(ns("filemap"), "", accept=c('.shp','.dbf','.sbn','.sbx','.shx',".prj"), multiple=TRUE),
                   br(),
                   leafletOutput(ns("mapview")),
                   br(),
                   actionButton(ns("sub2"),"upload study area to server")

                 )
                 )

      }else{
        insertUI(selector =paste0("#",ns("check_proj")),
                 where = "afterEnd",
                 ui=tagList(h5("project not found")))
      }

    })


    ## read in the base dat (not after with db)
    # study_area<-read.csv("C:/Users/reto.spielhofer/OneDrive - NINA/Documents/Projects/GEOPROSPECTIVE/admin_app/studyarea.csv")

    studyID<-eventReactive(input$check_proj,{
      studyID<-stri_rand_strings(1, 12, pattern = "[A-Za-z0-9]")
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
      studyID<-studyID()
      dt<-input$es_file
      if(is.null(dt)){
        return()
      }
      es_study<-read.csv(dt$datapath)
      es_study$studyID<-rep(studyID,nrow(es_study))
      es_study$projID<-rep(input$proj_id,nrow(es_study))
      output$es_table_out<-renderDT(
        es_study
      )
      saveRDS(rbind(es_study,es_in),"C:/Users/reto.spielhofer/OneDrive - NINA/Documents/Projects/GEOPROSPECTIVE/admin_app/es.rds")
    })




    ## upload the shp and attach uid
    observe({
      studyID<-studyID()
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
      map$studyID<-rep(studyID,nrow(map))
      map$projID<-rep(input$proj_id,nrow(map))
      map_out<-as.data.frame(map)
      study_geom<-rbind(study_geom,map_out)
      saveRDS(study_geom,"C:/Users/reto.spielhofer/OneDrive - NINA/Documents/Projects/GEOPROSPECTIVE/admin_app/study_geom/study_geom.rds")

      ## store the sf object and the project key in the bq

      ## plot it
      output$mapview<-renderLeaflet({
        leaflet(map) %>%
          addProviderTiles("CartoDB.Positron") %>%
          addPolygons(color = "green")
      })


    })

    ## upload csv table




  })
}

## To be copied in the UI
# mod_define_study_area_ui("define_study_area_1")

## To be copied in the server
# mod_define_study_area_server("define_study_area_1")

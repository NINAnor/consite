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
    fileInput(ns("filemap"), "", accept=c('.shp','.dbf','.sbn','.sbx','.shx',".prj"), multiple=TRUE),
    br(),
    plotOutput(ns("mapview")),
    br(),
    actionButton(ns("b1"),"next")
  )
}

#' define_study_area Server Functions
#'
#' @noRd
mod_define_study_area_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    rv1<-reactiveValues(
      u = reactive({})
    )

    observe({
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
      map <- sf::st_transform(map, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))


      ## generate_proj key
      # projID<-stri_rand_strings(1, 10, pattern = "[A-Za-z0-9]")

      ## store the sf object and the project key in the bq

      output$mapview<-renderPlot({
        plot(map)
      })


      # play back the value of the confirm button to be used in the main app

    })

    observeEvent(input$b1,{
      rv1$u <-reactive({1})
    })
    cond <- reactive({rv1$u()})

    return(cond)
  })
}

## To be copied in the UI
# mod_define_study_area_ui("define_study_area_1")

## To be copied in the server
# mod_define_study_area_server("define_study_area_1")

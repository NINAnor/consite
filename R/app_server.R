#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import dplyr
#' @import sf
#' @import stringi
#' @import DT
#' @noRd
projects<-readRDS("C:/Users/reto.spielhofer/OneDrive - NINA/Documents/Projects/GEOPROSPECTIVE/admin_app/projects.rds")
projects$dt_created<-as.character(projects$dt_created)
app_server <- function(input, output, session) {
  # Your application server logic
  # for testing, read in a dummy csv file (DB connection)
  observeEvent(input$create_pr,{
    projID<-stri_rand_strings(1, 8, pattern = "[A-Za-z0-9]")
    new_proj<-c(projID,input$proj_nat_name,input$proj_DESCR,"reto.spielhofer@nina.no",as.character(Sys.time()),"1")
    projects<-rbind(projects,new_proj)
    saveRDS(projects,"C:/Users/reto.spielhofer/OneDrive - NINA/Documents/Projects/GEOPROSPECTIVE/admin_app/projects.rds")
    output$projidtext<-renderText(paste0("Please note your project name: ",input$proj_nat_name, " and your project ID: ", projID))
  })

  mod_define_study_area_server("study_area")
  mod_explore_studies_server("explore_projects")
  mod_manage_study_server("manage_proj")

}

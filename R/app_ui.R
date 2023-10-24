#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      titlePanel(title =  div(img(src="logo.PNG", width ='120'), 'Admin portal of geoprospective'), windowTitle = "Admin Geopros" ),
      tabsetPanel(id = "inTabset",
                  tabPanel(title = "Create new project", value = "p0",
                           br(),
                           h5("Here you can create a new Geoprospective project. A project can contain more than one case study areas, to be defined in the next step"),
                           br(),
                           textInput("proj_nat_name","provide a short name of the project"),
                           br(),
                           textInput("proj_descr","provide a short description"),
                           br(),
                           actionButton("create_pr","create project"),
                           br(),
                           textOutput("projidtext")

                           ),
                  tabPanel(title = "Add case study area", value = "p1",
                           mod_define_study_area_ui("study_area")),
                  tabPanel(title = "Explore running studies", value = "p2",
                           mod_explore_studies_ui("explore_projects")),
                  tabPanel(title = "Manage studies", value = "p3",
                           mod_manage_study_ui("manage_proj")))
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www/"),
      app_title = "geoprospectiveADMINe"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

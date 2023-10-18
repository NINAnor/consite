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
                  tabPanel(title = "Create project", value = "p0",
                           mod_define_study_area_ui("study_area")),
                  tabPanel(title = "upload your ecosystem services", value = "p1"),
                  tabPanel(title = "invite participants", value = "p2"),
                  tabPanel(title = "manage studies", value = "p3"))
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
      path = app_sys("app/www"),
      app_title = "geoprospectiveADMINe"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

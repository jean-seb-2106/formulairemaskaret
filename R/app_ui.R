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
      h1("formulairemaskaret"),
      sidebarPanel(
        h2("Sélection du cours à modifier"),
        selectInput("cours", "Choisir un cours :", choices = NULL),

        h2("Modification du cours"),
        uiOutput("fields_ui"),  # Pour les champs dynamiques
        actionButton("update", "Appliquer les modifications")
      ),
      mainPanel(
        textOutput("message")  # Pour afficher un message de confirmation
      )
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
      app_title = "formulairemaskaret"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

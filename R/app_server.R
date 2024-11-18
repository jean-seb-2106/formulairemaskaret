#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom DBI dbDisconnect dbGetQuery dbExecute dbQuoteString
#' @noRd
app_server <- function(input, output, session) {

  observe({
    conn <- connect_to_db()
    on.exit(dbDisconnect(conn))

    query <- "SELECT nom FROM cours"
    noms_cours <- dbGetQuery(conn, query)$nom
    updateSelectInput(session, "cours", choices = noms_cours)
  })

  output$fields_ui <- renderUI({
    req(input$cours)  # Ne s'exécute que si un cours est sélectionné

    conn <- connect_to_db()
    on.exit(dbDisconnect(conn))

    # Récupérer les informations du cours sélectionné
    query <- paste0("SELECT * FROM cours WHERE nom = '", input$cours, "'")
    cours_data <- dbGetQuery(conn, query)

    # Générer dynamiquement les champs modifiables
    tagList(
      textInput("nom_cours", "Nom du cours :", value = cours_data$nom),
      textInput("description", "Description :", value = cours_data$descriptif)
    )
  })

  # observeEvent(input$update, {
  #   req(input$nom_cours, input$description)  # Vérifier les champs remplis
  #
  #   conn <- connect_to_db()
  #   on.exit(dbDisconnect(conn))
  #
  #   nom_cours_escaped <- dbQuoteString(conn, input$nom_cours)
  #   description_escaped <- dbQuoteString(conn, input$description)
  #
  #   # Mettre à jour les données dans la base
  #   query <- paste0(
  #     "UPDATE cours SET ",
  #     "nom = '", nom_cours_escaped, "', ",
  #     # "descriptif = '", description_escaped, "', ",
  #     "WHERE nom = '", nom_cours_escaped, "'"
  #   )
  #   dbExecute(conn, query)
  #
  #   # Afficher un message de confirmation
  #   output$message <- renderText("Les modifications ont été appliquées avec succès.")
  # })


  # Your application server logic
}

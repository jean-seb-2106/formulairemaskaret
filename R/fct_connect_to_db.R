#' connect_to_db
#'
#' @description une fonction pour se connecter à la bdd en mariadb
#'
#' @return un objet de type connexion à la base
#' @importFrom dotenv load_dot_env
#' @importFrom DBI dbConnect
#' @importFrom RMariaDB MariaDB
#' @export
#'
#' @examples
#' con <- connect_to_db()
connect_to_db <- function(){
  load_dot_env("C:/Users/XX9JQZ/Documents/packagesR/formulairemaskaret/.env")
  db_host <- Sys.getenv("DB_HOST")
  db_user <- Sys.getenv("DB_USER")
  db_name <- Sys.getenv("DB_NAME")

  DBI::dbConnect(
    MariaDB(),
    dbname = db_name,
    host = db_host,
    user = db_user,
    password = ""
  )

}


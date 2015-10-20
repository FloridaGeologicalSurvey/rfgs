#' @title Show Available FGS Connections
#'
#' @description
#' \code{show_all_connections} Show all available FGS database connections
#' 
#' @family connection functions
#' 
#' @details
#' This function reads a standard CSV list of connections distributed internally at the FGS
#' These connections provide the detail for reader access to internal FGS databases.
#' Use get_connection() to return an actual database connection object
#' 
#' @return (data.frame) A data frame object
#' @examples
#' library(rfgs)
#' show_all_connections()

show_all_connections <- function() {
    require(RPostgreSQL)
    con <- read.csv("//fgs-csksv12-srv/Archive/Toolboxes/r/fgsconnections.csv", header=T, colClasses = c("character","character","character","character"))
    rownames(con) <- con$name
    conn <- con[,-1]
    return(conn)
    
    }
    
        

#' @title Get FGS Database Connection
#'
#' @description
#' \code{get_connection} Read FGS connection parameters. Used to connect to internal FGS data sources.
#' 
#' @family connection functions
#' 
#' @details
#' This function reads a standard CSV list of connections distributed internally at the FGS
#' These connections provide the detail for reader access to internal FGS databases.
#' You must have an active network connection to floridadep.net in order to use this function.
#' Use show_all_connections() to get a list of available connections.
#' 
#' @param cname (chr) A character vector of length 1 with the connection name
#' @return An RPostgreSQL database connection object
#' @examples
#' library(rfgs)
#' library(RPostgreSQL)
#' borehole_db <- get_connection()
#' 
#' #list all tables in database
#' dbListTables(borehole_db)
#'
#' #list all fields in table
#' dbListFields(borehole_db, "well_index")
#'
#' #get the index table
#' boreholes <- dbGetQuery(borehole_db, "SELECT * FROM well_index")
#' str(boreholes)
#' 
#' #get a count of wells by county
#' boreholes <- dbGetQuery(borehole_db, "SELECT county, count(wnumber) AS cnt FROM well_index GROUP BY county ORDER BY cnt DESC;")
#'
#' #there are case problems with the county field, i.e. entries for 'Levy' and 'LEVY'. Use UPPER to fix.
#' boreholes <- dbGetQuery(borehole_db, "SELECT UPPER(county) as county, count(wnumber) AS cnt FROM well_index GROUP BY county ORDER BY cnt DESC;")
#'
#' #get the average totaldepth by county
#' boreholes <- dbGetQuery(borehole_db, "SELECT UPPER(county) AS county, avg(wnumber) AS mean FROM well_index GROUP BY county ORDER BY mean DESC;")
#'
#' #  !!! ALWAYS DISCONNECT FROM DATABASES WHEN YOU ARE DONE  !!! #
#' dbDisconnect(borehole_db)

get_connection <- function(cname = 'boreholes') {
    require(RPostgreSQL)
    con <- read.csv("//fgs-csksv12-srv/Archive/Toolboxes/r/fgsconnections.csv", header=T, colClasses = c("character","character","character","character"))
    rownames(con) <- con$name
    conn <- con[,-1]
    db_connect <- dbConnect(PostgreSQL(), host=conn[cname,'host'], db=conn[cname, 'db'], user=conn[cname,'user'], password=conn[cname,'password'])
    return(db_connect)
    
    }
    
        

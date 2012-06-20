#
# Author: Daniel Nüst
###############################################################################

require("cosm")

key <- Sys.getenv('COSM_API_KEY')
if (key == "") key <- readline('Cosm API key: ')

aqe <- getFeeds(key, q = "london", tag = "AirQualityEgg", per_page = 10)
str(aqe)
# OK


aqe <- getFeeds(key, tag = "AirQualityEgg", per_page = 10)
# tag only does not work...
str(aqe)

# FIXME
getFeeds(key, user = "marian", per_page = 100)

feeds2 <- getFeeds(key, q = "http://odlinfo.bfs.de/", page = 1, per_page = 20)


getFeeds(key, user = "nuest", per_page = 10)

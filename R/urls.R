#' feedUrl
#'
#' Construct the URL for a Cosm feed
#'
#' @param feed		feed ID
#' @param format	(optional) "csv", "xml", or "json"
#'
feedUrl <- function(feed, format) {
	url <- sprintf('http://api.cosm.com/v2/feeds/%s', feed)
	if (!missing(format))
		url <- paste(url, format, sep='.')
	return(url)
}

#' datastreamUrl
#'
#' Construct the URL for a Cosm datastream
#'
#' @param feed			feed ID
#' @param datastream	datastream ID
#'
datastreamUrl <- function(feed, datastream) {
	sprintf('%s/datastreams/%s', feedUrl(feed), datastream)
}

#' feedsUrl
#'
#' Construct the URL for a list of feeds
#' 
#' 
#' @param parameters	a named list of query parameters
#'
feedsUrl <- function(parameters) {
#	query <- ""
#	
#	# TODO this must be possible more elegantly
#	.paramNames <- names(parameters)
#	print(.paramNames)
#	for (i in seq(along = parameters)) {
#		query <- paste0(query, .paramNames[i], "=", parameters[i], "&")
#	}
	
#	.url <- sprintf('http://api.cosm.com/v2/feeds?%s', query)
	.url <- 'http://api.cosm.com/v2/feeds?'
	return(.url)
}
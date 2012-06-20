#' getFeed
#'
#' Fetch data from Cosm
#'
#' @param feed			feed ID
#' @param key			API key
#' @param ...			(optional) query string arguments, of the form key=value
#' @return				a Feed object (inherits from list)
#' @note				pass per_page=1000 to get the maximum number of results
#' @rdname get
#' @export
getFeed <- function(feed, key, ...) {
	url <- feedUrl(feed)
	header <- httpHeader(key)
	content <- httpGet(url, header, ...)
	parsed <- fromJSON(content)
	object <- as.Feed(parsed)
	class(object) <- addClass(object, 'Feed')
	return(object)
}

#' getDatapoints
#'
#' Fetch datapoints from a given feed or datastream
#'
#' @param feed			feed ID
#' @param key			API key
#' @param datastreams	datastream ID or IDs (optional; if none supplied will return all)
#' @return				zoo object
#' @rdname get
#' @export
getDatapoints <- function(feed, key, datastreams, ...) {
	require(zoo)
	args <- list(url=feedUrl(feed), header=httpHeader(key, accept='text/csv'), ...)
	if (!missing(datastreams)) {
		args <- c(datastreams=paste(datastreams, collapse=','), args)
	}
	content <- do.call('httpGet', args)
	long <- fromCSV(content, col.names=c('datastream', 'timestamp', 'value'))
	wide <- reshape(long, direction='wide', timevar='datastream', idvar='timestamp', v.names='value')
	object <- zoo(wide[,-1], order.by=wide[,1])
	datastreams <- sub("^value.", "", names(wide)[-1])
	if (length(datastreams) > 1) {
		colnames(object) <- datastreams
	}
	class(object) <- addClass(object, 'Datapoints')
	return(object)
}

#' getFeeds
#' 
#' Fetch available feeds based on keywords, users, ...
#' 
#' https://cosm.com/docs/v2/feed/list.html
#' 
#' @param page			Integer indicating which page of results you are requesting. Starts from 1.
#' @param per_page 		Integer defining how many results to return per page (1 to 1000).
#' @param content 		String parameter ('full' or 'summary') describing whether we want full or summary results. Full results means all datastream values are returned, summary just returns the environment meta data for each feed.
#' @param q 			Full text search parameter. Should return any feeds matching this string.
#' @param tag 			Returns feeds containing datastreams tagged with the search query.
#' @param user 			Returns feeds created by the user specified.
#' @param units 		Returns feeds containing datastreams with units specified by the search query.
#' @param status 		Possible values ('live', 'frozen', or 'all'). Whether to search for only live feeds, only frozen feeds, or all feeds. Defaults to all.
#' @param order 		Order of returned feeds. Possible values ('created_at', 'retrieved_at', or 'relevance').
#' @param show_user 	Include user login and user level for each feed. Possible values: true, false (default)
#' @return				list of feeds
#' @export 
getFeeds <- function(key, q = NA, user = NA, tag = NA, page = 1, per_page = 100, content = "summary", 
		units = NA, status = "all", order = "relevance", show_user = FALSE, ...) {
	.parameters = c()
	
	# TODO this can certainly be optimized
	if(!is.na(q))
		.parameters[["q"]] <- q
	if(!is.na(user))
		.parameters[["user"]] <- user
	if(!is.na(tag))
		.parameters[["tag"]] <- tag
	if(!is.na(units))
		.parameters[["units"]] <- units
	
	.parameters <- c(.parameters,
			list(page = page, per_page = per_page, content = content,
					status = status, order = order, show_user = show_user))
	
	url <- feedsUrl()
	header <- httpHeader(key)
	
	.args <- list(header = header, url = url)
	.args <- c(.args, as.list(.parameters))
	
	content <- do.call("httpGet", args = .args)
	parsed <- fromJSON(content)
	object <- as.Feed(parsed)
	class(object) <- addClass(object, 'FeedList')
	return(object)
}



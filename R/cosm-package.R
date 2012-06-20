require(RCurl)
require(rjson)
require(zoo)

#' Provides a rudimentary interface to the Cosm API
#'
#' \tabular{ll}{
#'  Package: \tab cosm\cr
#' Type: \tab Package\cr
#' Version: \tab 0.1\cr
#' Date: \tab 2012-06-20\cr
#' License: \tab BSD
#' LazyLoad: \tab yes\cr
#' }
#'
#' Cosm (http://www.cosm.com) is a platform, API and community focused on growing the Internet of Things. The Cosm API provides key-based read/write access to public and private datastreams from a multitude of connected devices.
#' 
#' This package provides a limited (read-only) subset of the full API. It's just enough to pull data into the R computing environment (http://www.r-project.org/), so that users can leverage a rich 3rd-party ecosystem of freely available, open-source libraries for statistical analysis and visualization.
#' 
#' 
#' @name cosm
#' @aliases cosm pachube
#' @docType package
#' @title Provides a rudimentary interface to the Cosm API
#' @author David Holstius \email{david.holstius@@berkeley.edu}
#' @references
#' \url{https://github.com/holstius/cosm}
#' @keywords package
#' @examples
#' key <- Sys.getenv('COSM_API_KEY')
#' if (key == "") key <- readline('Cosm API key: ')
#' feed <- readline('Cosm feed ID: ')
#' datapoints <- getDatapoints(feed, key, start=ISOdate(2012, 06, 01), duration="3hours", interval=60)

if (is.null(getOption('digits.secs'))) {
	message('Set options(digits.secs=3) for millisecond precision')
}

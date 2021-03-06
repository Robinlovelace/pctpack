% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/route_funs.R
\name{route_rolling_gradient}
\alias{route_rolling_gradient}
\title{Calculate rolling average gradient from elevation data at segment level}
\usage{
route_rolling_gradient(elevations, distances, lag = 1, n = 2, abs = TRUE)
}
\arguments{
\item{elevations}{Elevations, e.g. those provided by the \code{cyclestreets} package}

\item{distances}{Distances, e.g. those provided by the \code{cyclestreets} package}

\item{lag}{The window size of the smoothing function. The default, 3, will take
the mean of values before, after and including each value.}

\item{n}{The window size of the smoothing function.
The default, 3, will take the mean of values before, after and including
each value.}

\item{abs}{Should the absolute (always positive) change be returned? True by default}
}
\description{
Calculate rolling average gradient from elevation data at segment level
}
\examples{
r1 <- od_data_routes[od_data_routes$route_number == 2, ]
y <- r1$elevations
distances <- r1$distances
route_rolling_gradient(y, distances)
route_rolling_gradient(y, distances, abs = FALSE)
route_rolling_gradient(y, distances, n = 3)
route_rolling_gradient(y, distances, n = 4)
r1$elevations_diff_1 <- route_rolling_diff(y, lag = 1)
r1$rolling_gradient <- route_rolling_gradient(y, distances, n = 2)
r1$rolling_gradient3 <- route_rolling_gradient(y, distances, n = 3)
r1$rolling_gradient4 <- route_rolling_gradient(y, distances, n = 4)
d <- cumsum(r1$distances) - r1$distances / 2
diff_above_mean <- r1$elevations_diff_1 + mean(y)
par(mfrow = c(2, 1))
plot(c(0, cumsum(r1$distances)), c(y, y[length(y)]), ylim = c(80, 130))
lines(c(0, cumsum(r1$distances)), c(y, y[length(y)]))
points(d, diff_above_mean)
abline(h = mean(y))
rg <- r1$rolling_gradient
rg[is.na(rg)] <- 0
plot(c(0, d), c(0, rg), ylim = c(0, 0.2))
points(c(0, d), c(0, r1$rolling_gradient3), col = "blue")
points(c(0, d), c(0, r1$rolling_gradient4), col = "grey")
par(mfrow = c(1, 1))
}
\seealso{
Other route_funs: 
\code{\link{route_average_gradient}()},
\code{\link{route_rolling_average}()},
\code{\link{route_rolling_diff}()},
\code{\link{route_sequential_dist}()},
\code{\link{route_slope_matrix}()},
\code{\link{route_slope_vector}()}
}
\concept{route_funs}

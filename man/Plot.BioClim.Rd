% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Plotting.R
\name{Plot.BioClim}
\alias{Plot.BioClim}
\title{Visualise bioclimatic raster data and overlay sf polygons if desired.}
\usage{
Plot.BioClim(
  BioClims,
  Which = 1:19,
  SF,
  Water_Var = "Water Availability",
  ncol = 3,
  Size = 1,
  Shape = 1
)
}
\arguments{
\item{BioClims}{SpatRast object to visualise.}

\item{Which}{Numeric. Which bioclimatic variable(s) to visualise.}

\item{SF}{Optional. SF object which to overlay.}

\item{Water_Var}{Optional, character. Name of water availability variable in the bioclimatic variables.}

\item{ncol}{Number of columns for panel arrangement of plots}

\item{Size}{Optional. Size of SF overlay.}

\item{Shape}{Optional. Shape of SF overlay if points.}
}
\value{
A ggplot2 object visualising a raster.
}
\description{
Use the ggplot2 plotting engine to easily create visualisations of biolcimatic raster data - like the ones obtained using BioClim(...) - and overlay sf polygon data if desired.
}
\examples{
BC_rast <- terra::rast(system.file("extdata", "CN_BC.nc", package = "KrigR"))
Plot.BioClim(BioClims = BC_rast, Water_Var = "Soil Moisture (0-7cm)")

}
\seealso{
\code{\link{BioClim}}.
}

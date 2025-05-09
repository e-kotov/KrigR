% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CovariateSetup.R
\name{CovariateSetup}
\alias{CovariateSetup}
\title{Preparing Covariate Data for Use in Kriging}
\usage{
CovariateSetup(
  Training,
  Target,
  FilePrefix = "",
  Covariates = "GMTED2010",
  Source = "Origin",
  Extent,
  Buffer = 0.5,
  Dir = getwd(),
  Keep_Global = FALSE,
  FileExtension = ".nc",
  Compression = 9
)
}
\arguments{
\item{Training}{A SpatRaster file containing the data which is to be downscaled. Covariate data will be resampled to match this.}

\item{Target}{Either numeric or a SpatRaster. If numeric, a single number representing the target resolution for the kriging step (i.e. wich resolution to downscale to). If a SpatRaster, data that the covariates and kriged products should align with. In case of a numeric input, covariate data is aggregated as closely as possible to desired resolution. If a SpatRaster, covariate data is resampled to match desired output directly.}

\item{FilePrefix}{Character. A file name prefix for the produced files.}

\item{Covariates}{Either character or a SpatRaster. If character, obtain frequently used and provably useful covariate data (i.e., GMTED2010 and soil data) and prepare for use in Kriging. Supported character values are "GMTED2010", "tksat", "tkdry", "csol", "k_s", "lambda", "psi", and "theta_s". If a SpatRaster, a user-supplied set of covariate data to be prepared for use in Kriging.}

\item{Source}{Character. Only comes into effect when Covariates argument is specified as a character. Whether to attempt download of covariate data from the official sources (Source = "Origin") or a static copy of the data set on a private drive (Source = "Drive"). Default is "Origin".}

\item{Extent}{Optional, prepare covariate data according to desired spatial specification. If missing/unspecified, maximal area of supplied data and covariat sets is used. Can be specified either as a raster object, an sf object, a terra object, or a data.frame. If Extent is a raster or terra object, covariates will be prepared according to rectangular extent thereof. If Extent is an sf (MULTI-)POLYGON object, this will be treated as a shapefile and the output will be cropped and masked to this shapefile. If Extent is a data.frame of geo-referenced point records, it needs to contain Lat and Lon columns around which a buffered shapefile will be created using the Buffer argument.}

\item{Buffer}{Optional, Numeric. Identifies how big a circular buffer to draw around points if Extent is a data.frame of points. Buffer is expressed as centessimal degrees.}

\item{Dir}{Character/Directory Pointer. Directory specifying where to download data to.}

\item{Keep_Global}{Logical. Only comes into effect when Covariates argument is specified as a character. Whether to retain raw downloaded covariate data or not. Default is FALSE.}

\item{FileExtension}{Character. A file extension for the produced files. Supported values are ".nc" (default) and ".tif" (better support for metadata).}

\item{Compression}{Integer between 1 to 9. Applied to final .nc file that the function writes to hard drive. Same as compression argument in terra::writeCDF(). Ignored if FileExtension = ".tif".}
}
\value{
A list containing two SpatRaster objects (Training and Target) ready to be used as covariates for kriging, and two files called Covariates_Target and Covariates_Train in the specified directory.

The SpatRasters produced and stored when specifying the Covariates argument as a character string and setting the Keep_Global argument to TRUE contain metadata/attributes as a named vector that can be retrieved with terra::metags(...):
\itemize{
\item{Citation}{ - A string which to use for in-line citation of the data product.}
}
}
\description{
This function is used to setup products of covariate data ready for use in Kriging. This functionality can either be applied to user-supplied covariate data or ready-made data products such as the global dataset of soil hydraulic and thermal parameters for earth system modeling (available at \url{http://globalchange.bnu.edu.cn/research/soil4.jsp}) and the median statistic of the Global Multi-resolution Terrain Elevation Data (GMTED2010; available at \url{https://topotools.cr.usgs.gov/gmted_viewer/gmted2010_global_grids.php}). In case of the latter, the data is downloaded at 30 arc-sec latitude/longitude grid cells and subsequently resampled to match training and target resolutions specified by the user.
}
\examples{
\dontrun{
## Rectangular Covariate data according to input data
CDS_rast <- terra::rast(system.file("extdata", "CentralNorway.nc", package = "KrigR"))
Covariates_ls <- CovariateSetup(
  Training = CDS_rast,
  Target = 0.01,
  Covariates = "GMTED2010",
  Keep_Global = TRUE,
  FileExtension = ".nc"
)
Plot.Covariates(Covariates_ls)

## Shapefile-limited covariate data
data("Jotunheimen_poly")
CDS_rast <- terra::rast(system.file("extdata", "CentralNorway.nc", package = "KrigR"))
Covariates_ls <- CovariateSetup(
  Training = CDS_rast,
  Target = 0.01,
  Covariates = "GMTED2010",
  Extent = Jotunheimen_poly,
  Keep_Global = TRUE,
  FileExtension = ".nc"
)
Plot.Covariates(Covariates_ls, SF = Jotunheimen_poly)

## buffered-point-limited covariate data
data("Mountains_df")
CDS_rast <- terra::rast(system.file("extdata", "CentralNorway.nc", package = "KrigR"))
Covariates_ls <- CovariateSetup(
  Training = CDS_rast,
  Target = 0.01,
  Covariates = c("tksat", "tkdry", "csol", "k_s", "lambda", "psi", "theta_s"),
  Source = "Drive",
  Extent = Mountains_df,
  Buffer = 0.2,
  Keep_Global = TRUE,
  FileExtension = ".nc"
)
Plot.Covariates(Covariates_ls)
}
}
\seealso{
\code{\link{Kriging}}, \code{\link{Plot.Covariates}}.
}

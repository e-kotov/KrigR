% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Temporal.R
\name{Temporal.Cumul}
\alias{Temporal.Cumul}
\title{Make cumulatively stored records into sequential ones}
\usage{
Temporal.Cumul(
  CDS_rast,
  CumulVar,
  BaseResolution,
  BaseStep,
  Type,
  TZone,
  verbose = TRUE
)
}
\arguments{
\item{CDS_rast}{SpatRaster}

\item{CumulVar}{Logical. Whether to apply cumulative back-calculation}

\item{BaseResolution}{Character. Base temporal resolution of data set}

\item{BaseStep}{Numeric. Base time step of data set}

\item{Type}{CDS Dataset type}

\item{TZone}{Character. Time zone for queried data.}

\item{verbose}{Logical. Whether to print/message function progress in console or not.}
}
\value{
A SpatRaster

break apart sequence by UTC days and apply back-calculation per day in pblapply loop, for loop for each hour in each day
}
\description{
Takes a SpatRaster of cumulatively stored records and returns a SpatRaster of sequential counterparts
}

# How to calculate the distance from a ZIP to a point in R

This example depends on the TigerLine ZCTA shapefile. That file is 500+ MB so I downloaded it, threw out the bulky shapes, and kept just the data. That is what is saved in `ZIPS.RData`. If you'd like to load this from the source simply remove `ZIPS.RData` and re-run the script.

Note that the USPS does not have shapes or centroids for ZIP codes. A ZIP code is simply a bundle of addresses. The US Census creates, for their decennial census, "ZIP Code Tabulation Areas" which are provide a geographic representation of ZIP codes.

The USPS frequently adds and removes ZIP codes. These changes are not reflected in the ZCTA files. Commercial services provide data sets that properly reflect these changes but I'm not using one in this example.

## Usage

Start up R:

```
install.packages("fields")
install.packages("rgdal") # optional: only needed for reading shapefiles
source("distance_to_zipcode_example.R")
```

...or open and source using RStudio.

set.seed(1)

# Get this package with: install.packages("fields")
require(fields)

# File with the cached ZIP code data
ZIPS.file = "ZIPS.RData"

# Number of fake points
n = 1000

# Try to load the cached ZIPS data, quietly
try(suppressWarnings(load(ZIPS.file)), silent=TRUE)

# Load the ZIP code table if it isn't available.
if (!exists("ZIPS")) {
  # This package is required to load shapefiles
  require(rgdal)
  # http://www2.census.gov/geo/tiger/TIGER2014/ZCTA5/tl_2014_us_zcta510.zip
  # Unzip tl_2014_us_zcta510.zip from URL above into a directory named raw/tl_2014_us_zcta510
  ZIPS.spdf = readOGR("raw/tl_2014_us_zcta510/", "tl_2014_us_zcta510")
  ZIPS = ZIPS.spdf@data # keep just the data and throw away the shapes

  # Make the lat/long a numeric value
  ZIPS$lon = as.numeric(as.character(ZIPS$INTPTLON10))
  ZIPS$lat = as.numeric(as.character(ZIPS$INTPTLAT10))
  
  save("ZIPS", file=ZIPS.file)
}

# Generate some fake long/lat pairs distributed among the ZIP codes
LOC = data.frame(
  lon = runif(n, min(ZIPS$lon), max(ZIPS$lon)),
  lat = runif(n, min(ZIPS$lat), max(ZIPS$lat))
  )

# Lets just pick some random ZIPs
ZIPS = ZIPS[sample(1:nrow(ZIPS), n),]

DIST = rdist.earth(
  as.matrix(LOC[,c("lon", "lat")]),
  as.matrix(ZIPS[,c("lon", "lat")]),
  miles=FALSE
)

# Each column in DIST is a different ZIP code. I'm taking the numeric version of the zip
# code and ensuring that "610" is formatted as "00610".
colnames(DIST) = sprintf("%0.5d", as.numeric(ZIPS$ZCTA5CE10))

# Distance between zip 04314 to the first location
print(DIST[1,1])

# Lookup by ZIP
print(DIST[1, "04314"])



# NEON API token ----------------------------------------------------------


library(neonUtilities)

NEON_TOKEN <- "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJhdWQiOiJodHRwczovL2RhdGEubmVvbnNjaWVuY2Uub3JnL2FwaS92MC8iLCJzdWIiOiJua3c1NEBuYXUuZWR1Iiwic2NvcGUiOiJyYXRlOnB1YmxpYyIsImlzcyI6Imh0dHBzOi8vZGF0YS5uZW9uc2NpZW5jZS5vcmcvIiwiZXhwIjoxODIwNjgzMjgxLCJpYXQiOjE2NjMwMDMyODEsImVtYWlsIjoibmt3NTRAbmF1LmVkdSJ9.n0Um8gn-kNX9dcKb696-4zWONM8UA5V0AgoVWN1yLRXyMFwcw0WIn-u3wO7DeTy3vmptGF5VZzMcfyd0sNjE6g"

# save your neon token as an Rdata file so it can be called in later
save(NEON_TOKEN, file = "neon_token_source.Rdata")

# use the loadByProduct() function to download data. Your API token is entered as the optional token input parameter
foliar <- loadByProduct(dpID="DP1.10026.001", site="all", 
                        package="expanded", check.size=F,
                        token=NEON_TOKEN)

# all neonUtilities functions that involve downloading data or otherwise accessing the API; you can use the token input with all of them
# For example, when downloading remote sensing data:
chm <- byTileAOP(dpID="DP3.30015.001", site="WREF", 
                 year=2017, check.size=F,
                 easting=c(571000,578000), 
                 northing=c(5079000,5080000), 
                 savepath=wd,
                 token=NEON_TOKEN)


# Sect 2.8 - Wind River flux site example --------------------------------------------

# install.packages("devtools")
# devtools::install_github("NEONScience/NEON-geolocation/geoNEON")

# load package
library(neonUtilities)
library(geoNEON)
library(sp)

# supressing strings as factors
options(stringsAsFactors=F)

# pull in the vegetation structure data using the loadByProduct() function in the neonUtilities package.
# dpID: data product ID; (woody vegetation structure = DP1.10098.001
# site: 4-letter site code; Wind River = WREF
# package: basic or expanded; we’ll begin with a basic here
veglist <- loadByProduct(dpID="DP1.10098.001", site="WREF", package="basic", check.size=FALSE, token = NEON_TOKEN)

# Now, use the getLocTOS() function in the geoNEON package to get precise locations for the tagged plants. You can refer to the package documentation for more details.
vegmap <- getLocTOS(veglist$vst_mappingandtagging, 
                    "vst_mappingandtagging")

# need to merge the mapped locations of individuals (the vst_mappingandtagging table) with the annual measurements of height, diameter, etc (the vst_apparentindividual table).
veg <- merge(veglist$vst_apparentindividual, vegmap, 
             by=c("individualID","namedLocation",
                  "domainID","siteID","plotID"))

# best practice is to always do a quick visualization to make sure that you have the right data and that you understand its spread
symbols(veg$adjEasting[which(veg$plotID=="WREF_075")], 
        veg$adjNorthing[which(veg$plotID=="WREF_075")], 
        circles=veg$stemDiameter[which(veg$plotID=="WREF_075")]/100/2, 
        inches=F, xlab="Easting", ylab="Northing")

# estimate of uncertainty. Let’s overlay estimates of uncertainty for the location of each stem in blue:
symbols(veg$adjEasting[which(veg$plotID=="WREF_075")], 
        veg$adjNorthing[which(veg$plotID=="WREF_075")], 
        circles=veg$stemDiameter[which(veg$plotID=="WREF_075")]/100/2, 
        inches=F, xlab="Easting", ylab="Northing")
symbols(veg$adjEasting[which(veg$plotID=="WREF_075")], 
        veg$adjNorthing[which(veg$plotID=="WREF_075")], 
        circles=veg$adjCoordinateUncertainty[which(veg$plotID=="WREF_075")], 
        inches=F, add=T, fg="lightblue")



# Sect 2.9 Intro to NEON Exercise Part 1 ----------------------------------






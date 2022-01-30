
# get all installed package details in a data frame
getOld <- as.data.frame(
  installed.packages(), 
  row.names = F
)

write.csv(installedPreviously, './packages/installed_previously.csv', row.names = F)
# Creates a csv file that contains all package details installed in the old pc

# Read the csv file from old pc
installedPreviously <- read.csv('packages/installed_previously.csv')

# get all installed package details in a data frame
installedNow <- as.data.frame(  
  installed.packages(),
  row.names = F
)

# finds packages that are not installed in the new pc
toInstall <- setdiff(installedPreviously$Package, installedNow$Package)

# installs the packages that are not installed
install.packages(toInstall)

# to install the same versions
for(i in toInstall) {
  ver = installedPreviously[installedPreviously$Package == i, "Version"]
  message("(^_^) Installing ",i," Version = ",ver)
  devtools::install_version(package = i, version = ver)
}


commonPackages <- merge(installedNow[,c("Package","Version")], 
                        installedPreviously[,c("Package","Version")], 
                        by = "Package", 
                        suffixes = c("Now","Previously"))

changedVerPackages <- data.frame(Package=character(0),
                                 VersionNow=character(0),
                                 VersionPreviously=character(0))

changedVerPackages <- data.frame()
for(i in 1:nrow(commonPackages)) {
  # If versions don't match add it to the data frame
  if (commonPackages$VersionNow[i] != commonPackages$VersionPreviously[i]) {
    changedVerPackages <- rbind(changedVerPackages, commonPackages[i, ])
  }
}


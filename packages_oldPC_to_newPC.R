
packages_oldPC_to_newPC <- function(
  do = "old", 
  # old: writes csv file containing old packages' details
  # new: installs packages in new computer
  location = "installed_previously.csv",
  version,
  # same: to install the same versions
  # update: to install the updated versions
  ...
){
  if (do == "old") {
    # get all installed package details in a data frame
    installedPreviously <- as.data.frame(installed.packages(),
                                         row.names = F)
    
    # writing a csv that contains old computer's package details
    write.csv(x = installedPreviously,
              file = paste0(location),
              row.names = F)
  } else if (do == "new"){
    # Read the csv file from old computer
    installedPreviously <- read.csv(location)
    
    # get all installed package details in a data frame
    installedNow <- as.data.frame(installed.packages(),
                                  row.names = F)
    # finds packages that are not installed in the new computer
    toInstall <- setdiff(installedPreviously$Package,
                         installedNow$Package)
    
    if (version == "same") {
      # to install the same versions
      for (i in toInstall) {
        ver = installedPreviously[installedPreviously$Package == i, "Version"]
        message("(^_^) Installing ", i, " Version = ", ver)
        if(!require(devtools)) install.packages(devtools)
        devtools::install_version(package = i, version = ver)
      }
    } else if (version == "update") {
      # installs the packages that are not installed
      install.packages(toInstall)
    }
    # get packages that are common in both computers
    commonPackages <- merge(installedNow[,c("Package","Version")], 
                            installedPreviously[,c("Package","Version")], 
                            by = "Package", 
                            suffixes = c("Now","Previously"))
    
    # get packages whose package versions are changed
    changedVerPackages <- data.frame(Package=character(0),
                                     VersionNow=character(0),
                                     VersionPreviously=character(0))
    
    # data frame that contains packages and versions of unmatched versions
    for(i in 1:nrow(commonPackages)) {
      # If versions don't match add it to the data frame
      if (commonPackages$VersionNow[i] != commonPackages$VersionPreviously[i]) {
        changedVerPackages <- rbind(changedVerPackages, commonPackages[i, ])
      }
    }
    return(changedVerPackages)
  }
}
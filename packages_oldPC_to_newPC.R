
packages_oldPC_to_newPC(do = "old", location = "installed_previously.csv", install = T){
  if(do == "old"){
    
    # get all installed package details in a data frame
    installedPreviously <- as.data.frame(
      installed.packages(), 
      row.names = F
    )
    
    # writing a csv that contains old computer's package details
    write.csv(x = installedPreviously, 
              file = paste0(location), 
              row.names = F)
  } else if (do == "new"){
    # Read the csv file from old pc
    installedPreviously <- read.csv(location)
    
    # get all installed package details in a data frame
    installedNow <- as.data.frame(  
      installed.packages(),
      row.names = F
    )
    
    if(install = T){
      
      # finds packages that are not installed in the new pc
      toInstall <- setdiff(installedPreviously$Package, installedNow$Package)
      
      # installs the packages that are not installed
      install.packages(toInstall)
    }
  }
}







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


# Easily Install Packages From Your Other Computer
Installs the packages that are in an old computer to a new computer with updated why versions or same versions.

Download **packages_oldPC_to_newPC.R** and source it in your computer.

Arguments:\
do = character; takes the value 'old' by default which writes a csv file containing details of old packages, and the argument 'new' to install packages in the new computer.\
location = character; takes file's location and name, e.g., "installed_previously.csv"\
version = character; applicable when do = "new", takes the value 'same' to install the same versions, 'update' otherwise.

Returns:\
changedVerPackages = dataframe; contains three columns: Package, VersionNow, VersionPreviously.\

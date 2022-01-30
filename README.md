# Easily Install Packages From Your Other Computer
Installs the packages that are in an old computer to a new computer with updated why versions or same versions.

To copy the packages from one place to another:\
Step 1: Download *packages_oldPC_to_newPC.R* and source it in your old computer.\
Step 2: Get the generated CSV file in the current working directory, or the location what you've selected. Send it to your new computer.\
Step 3: Source *packages_oldPC_to_newPC.R* in your new computer.\
Step 4: Run the function with necessary arguments.

**Arguments:**\
`do` = character; takes the value 'old' by default which writes a csv file containing details of old packages, and the argument 'new' to install packages in the new computer.\
`location` = character; takes file's location and name, e.g., "installed_previously.csv"\
`version` = character; applicable when do = "new", takes the value 'same' to install the same versions, 'update' otherwise.

Returns:\
changedVerPackages = dataframe; contains three columns: Package, VersionNow, VersionPreviously.\

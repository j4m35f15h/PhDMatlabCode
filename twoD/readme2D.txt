There are a lot of functions here that are tied to the mathematical workings of the 
model.

First, to run the test version of the model with a randomised dataset:

Ensure that the folder is in the matlab path.
Into the command window, type:
"test"
(It takes around 4 minutes to run)


To visualise the results, first add the "visualisationFunctions" folder to the matlab
path. The following scripts do the following:

showTLattice - plots the rudiment outline as well as the lattice intersections
showData - plots the rudiment outline with the data inside.
showLattice - plots the transformation imposed on the rudiment outline and lattice
obtainGrowthMap - runs the lattice comparison to obtain the tensor field describing
		  the transformation
displayGrowthMap - Uses the tensor field to plot two heatmaps describing the growth
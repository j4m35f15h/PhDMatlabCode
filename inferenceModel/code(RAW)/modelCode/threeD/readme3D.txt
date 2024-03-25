Similar to the 2D folder, most of the functions are related to the different mathematical
elements of the model.

To run the test version of the model with a randomised dataset:

Add the following folders to the matlab path: "threeD", "twoD", "inpolyhedron", "stl",
"stlread".
Into the command window, type:
"test3D"
(It takes around 30 minutes to run)


To visualise the results:
showLattice3D - shows the virtual rudiment as well as the lattice surrounding it
showTLattice3D - shows the transformed rudiment and lattice (not the simulated one)

To show the growth map, type the following into the command window:
displayGrowthMap3D(lattice,latticeNew,object,theta,rows,cols,deps)



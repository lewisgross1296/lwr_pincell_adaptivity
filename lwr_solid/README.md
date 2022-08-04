# In order to generate the mesh
`~/cardinal/cardinal-opt -i mesh.i --mesh-only`
# In order to create the XML files with the OpenMC model
`python make_openmc_model.py`
# In order to run the solid cell problem with multiphysics
`mpiexec -np 8 ~/cardinal/cardinal-opt -i solid.i --n-threads=2`
# In order to run the unstructured mesh problem with multiphysics
`mpiexec -np 24 ~/cardinal/cardinal-opt -i solid_um.i --n-threads=2`
# In order to run the LWR pincell model with adaptivity, use the command
`mpiexec -np 24 ~/cardinal/cardinal-opt -i solid_um_adap.i --n-threads=2`
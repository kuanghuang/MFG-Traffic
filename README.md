# MFG

1. The struct `tra` is used to record information of a specific traffic model, see `utils/model_step_up.m` for its member variables and construction function.
2. Three models are simulated: (i) LWR; (ii) MFG_NonSeparable; (iii) MFG_Separable. The solutions are visualized in several formats. The folder `utils` contains utility functions for those tasks.

### LWR
Solving the LWR model. Both the Lax-Friedrichs and Godunov solvers are provided. Run `simu.m` to simulate and `plotfig_3d.m` to plot the density evolution.

### MFG_NonSeparable
Solving the MFG model with the non-separable cost function. Run `simu.m` to simulate and `plotfig_3d.m` to plot the density evolution. Run `plotfig_traj.m` to plot cars' trajectories. Run `convergence.m` to compute and plot the solution convergence.

### MFG_Separable
Solving the MFG model with the separable cost function. Similar to MFG_NonSeparable.

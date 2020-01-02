# trajectory

## Programs
* `many_initial_guesses`: generates initial guesses for the optimization. It runs either `initial_guess_fourier` or `initial_guess_park`: many times and takes the best
* `optimization`: runs `fmincon` or `ga` to find an optimized trajectory
* `criterion`: is the criterion to be minimized by the optimization. I'm using the condition number
* `constraints`: checks if the trajectory respects the joint limits
* `fcn_fourier` and `fcn_park`: are the functions that generate the trajectories given the parameters. They call auxiliary scripts `traj_fourier` and `traj_park_jnt`
* `regressor` and `regressor_fr`: correspond to the dynamic model calculated previously, one without friction and the other with
* `park_params`: calculates the polinomial coefficients in terms of the cosine coefficients for given boundary conditions. This was calculated then hardcoded in `traj_park_jnt` (messy, I know, but the boundary values shouldn't change so not too bad)
* `plot_traj`: is used to plot the trajectories
* `divergencia_trajetoria*`: plots the difference between the planned and executed trajectories
* `make_csv`: generates the csv files with the trajectory to be used as reference by the robot

## How to use this
* Run `many_initial_guesses` to generate new initial guesses. Then run `optimization` to generate a good trajectory. Finally, run `make_csv` to create csv files and use the `vel` (velocity) file as reference for the robot.

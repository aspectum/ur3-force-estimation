# identification

## Programs
* `least_squares`: solves the identification equation for the given trajectory and saves the dynamic parameters
* `evaluation`: is used to evaluate the identification and plot the graphics
* `regressor` and `regressor_fr`: correspond to the dynamic model calculated previously, one without friction and the other with
* `sgn`: is a function to return the sign (positive, negative or zero) of the argument
* `fitness`: calculates the Mean Squared Error between the measured torques and calculated torques
* `torque_from_regressor`: calculates the torque using the dynamic model and the given dynamic parameters
* `textprogressbar`: neat utility to show a progress bar. Credits to [Paul at Matlab File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/28067-text-progress-bar)

The `trajectory` folder contains the scripts used to generate the identification trajectories

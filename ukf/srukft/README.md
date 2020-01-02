# srukf

## Programs
* `square_root_ukf`: Implementation of the SRUKF, to be used with collected data
* `live_srukf`: SRUKF to be used live, connected to ROS
* `sr_ukf`: one iteration of the filter
* `calc_sigma_points`: function that calculates the sigma points
* `state_transition`: function that defines the new state from the previous state
* `measurement`: function that defines the measuremet from the state
* `std_calc`, `accel_array` and `torque_array`: scripts to estimate values of process and measurement noise
* `add_force`: function used to generate a torque signal from a simulated external force
* `graphics_offline`: plotting
* `textprogressbar` neat utility to show a progress bar. Credits to [Paul at Matlab File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/28067-text-progress-bar)
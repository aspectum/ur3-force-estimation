# catkin_ur3

## What's in here?
* `ur3_scripts` contains the scripts that are sent to the UR3 via a TCP socket
* `data` contains both the bags created by rosbag and the csv files of the reference trajectory
* The ROS programs are:
    * `interface`: communicates with the robot, sending the reference trajectory and receiving the sensor data
    * `send_trajectory`: reads the csv with the refenrence trajectory and publishes on a topic for `interface`
    * `subsampler`: subsamples the sensor data
    
Most of this was made by [Rafael Ramos](https://github.com/lara-unb/UR3_interface), but modified to fit my needs, except the `send_trajectory` and `subsampler` programs.

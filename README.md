# UR3 Force Estimation
My graduation thesis, consisting in estimating the end-effector force on the UR3 robot manipulator

## What's in these folders?
* The derivation of the dynamic model is in `mathematica`, and was done in the Wolfram Mathematica software. Even if you don't have Mathematica, you can open the `.m` files with a text editor and see the code. The generated matrices are in the `path` folder
* `experiment` contains experimental data collected from the robot. It contains the raw data (rosbag data) and the scripts used to unpack the bags and to filter/derivate
* `identification` contains the codes used to generate the identification trajectory and to get the dynamic parameters from the model and from the data
* `ukf` contains the Unscented Kalman Filter code for the force estimation
* `ros` contains a simple MATLAB program that connects to the ROS network and plots the measured data in real time. This program was used as a test to figure out how to do it later with the ukf
* `data` contains all the generated `.mat` files by all the programs
* `catkin_ur3` contains the ROS programs

## How to use
First, run `setup.m` to set up the path to the folder. Then you can run whatever you like. My workflow was first deriving the dynamic model, then generating a identification trajectory, solving the identification and finally run the ukf.

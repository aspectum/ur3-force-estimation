# ur3-force-estimation
My graduation thesis, consisting in estimating the end-effector force on the UR3 robot manipulator

## What's in here?
* The derivation of the dynamic model is in `mathematica`, and was done in the Wolfram Mathematica software.
* `experiment` contains experimental data collected from the robot
* `identification` contains the codes used to generate the identification trajectory and to get the dynamic parameters from the model and from the data
* `ukf` contains the Unscented Kalman Filter code for the force estimation

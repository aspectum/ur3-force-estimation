#include "ros/ros.h"
#include "sensor_msgs/JointState.h"
#include <cmath>

using namespace std;
int fs = 50;
float alpha = 1-pow(0.05, 1/ceil(125/fs));
float beta = 1-alpha;

float pos[6] = {0,0,0,0,0,0};
float vel[6] = {0,0,0,0,0,0};
float torque[6] = {0,0,0,0,0,0};

void arm_Callback(const sensor_msgs::JointState::ConstPtr& arm_data){
	
	for (int i=0; i<6; i++) {
        pos[i] = alpha * arm_data->position[i] + beta * pos[i];
        vel[i] = alpha * arm_data->velocity[i] + beta * vel[i];
        torque[i] = alpha * arm_data->effort[i] + beta * torque[i];
    }
    
}

int main(int argc, char **argv) {

    ros::init(argc, argv, "subsampler");
    ros::NodeHandle node;
    ros::Publisher sender = node.advertise<sensor_msgs::JointState>("subsampled_arm", 100);
    ros::Subscriber receiver = node.subscribe("arm", 10, arm_Callback);
    ros::Rate loop_rate(fs);

    sensor_msgs::JointState arm_ss;

    arm_ss.header.frame_id = " ";
    arm_ss.name.resize(6);
    arm_ss.position.resize(6);
    arm_ss.velocity.resize(6);
    arm_ss.effort.resize(6); 
    arm_ss.name[0] = "Base";
    arm_ss.name[1] = "Shoulder";
    arm_ss.name[2] = "Elbow";
    arm_ss.name[3] = "Wrist 1";
    arm_ss.name[4] = "Wrist 2";
    arm_ss.name[5] = "Wrist 3";

    while (ros::ok()) {

        for (int i=0; i<6; i++) {
            arm_ss.position[i] = pos[i];
            arm_ss.velocity[i] = vel[i];
            arm_ss.effort[i] = torque[i];
        }

        arm_ss.header.stamp = ros::Time::now();
        sender.publish(arm_ss);

        ros::spinOnce();
        loop_rate.sleep();
    }

    return 0;
}
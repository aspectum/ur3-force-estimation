#include "ros/ros.h"
// #include "std_msgs/Float64.h"// lib demo_1
#include "std_msgs/Float64MultiArray.h"
#include "parsecsv.h"

using namespace std;

int main(int argc, char **argv) {

    if (argc < 3) {
        cout << "Please pass the file name and sampling rate as argument" << endl;
        return 0;
    }

    cout << argv[1] << endl;
    int fs = atoi(argv[2]);
    cout << fs << endl;

    ros::init(argc, argv, "send_trajectory");
    ros::NodeHandle node;
    ros::Publisher sender = node.advertise<std_msgs::Float64MultiArray>("trajectory", 100);
    ros::Rate loop_rate(fs);
    int samples=0, joints=6;

    std_msgs::Float64MultiArray spd;

    vector<vector<double>> data = parsecsv(argv[1]);

    samples = data.size();
    joints = data[0].size();
    spd.data.resize(joints);

    for(int i=0; i<samples; i++) {
        for(int j=0; j<joints; j++) {
            spd.data[j] = data[i][j];
        }
        sender.publish(spd);
        cout << i << endl;
        ros::spinOnce();
		loop_rate.sleep();
    }

    return 0;
}
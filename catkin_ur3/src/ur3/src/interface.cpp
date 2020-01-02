// Programa para teste na junta 5 do ur3////////////////////////////////
//commando to setup joystick
//rosparam set joy_node/dev "/dev/input/jsX" change X for your divice.
//rosrun joy joy_node 
//rostopic echo joy 
////////////////////////////////////////////////////////////////////////
#include "ros/ros.h"
#include <std_msgs/Empty.h>
#include <boost/thread/thread.hpp>
#include "sensor_msgs/JointState.h"
#include "control_msgs/GripperCommand.h"
#include "std_msgs/Header.h"
#include "sensor_msgs/Joy.h"
#include "ur3/end_Effector_msg.h"
#include "geometry_msgs/Wrench.h"
#include "geometry_msgs/Pose.h"
#include "ur3/ref_msg.h"
#include "std_msgs/Float64.h"// lib demo_1
#include "std_msgs/Float64MultiArray.h"
#include <X11/keysymdef.h>
#include <sys/socket.h>
#include <stdlib.h> 
#include <netinet/in.h> 
#include <iostream>
#include <stdio.h>   
#include <string.h>
#include <string> 
#include <stdlib.h>
#include <sstream>
#include <inttypes.h>
#include <ctime>
#include "open_socket.h"
#include "send_script.h"


float pi = 3.14159265359;
float trajectory_reference[6] = {0, 0, 0, 0, 0, 0};

inline int reverse_word(int32_t num){
	uint32_t b0,b1,b2,b3;
	uint32_t res;
	b0 = (num & 0x000000ff) << 24u;
	b1 = (num & 0x0000ff00) << 8u;
	b2 = (num & 0x00ff0000) >> 8u;
	b3 = (num & 0xff000000) >> 24u;
	res = b0 | b1 | b2 | b3;
	return res;
}  

void send_data(int new_socket){
   
  int32_t buffer_in_[6];
  ros::NodeHandle node;
  ros::Publisher ref_pub = node.advertise<ur3::ref_msg>("ref",10);
  ur3::ref_msg ref;

  ref.refer.data.resize(6);
  ros::Rate loop_rate(125);
  float norma_float = 1000000.0;
  
  while (ros::ok()){
	  	ref.refer.data[0] = trajectory_reference[0];
		buffer_in_[0] = (int)(trajectory_reference[0]*norma_float);
		buffer_in_[0] = reverse_word(buffer_in_[0]);
		ref.refer.data[1] = trajectory_reference[1];
		buffer_in_[1] = (int)(trajectory_reference[1]*norma_float);
		buffer_in_[1] = reverse_word(buffer_in_[1]);
		ref.refer.data[2] = trajectory_reference[2];
		buffer_in_[2] = (int)(trajectory_reference[2]*norma_float);
		buffer_in_[2] = reverse_word(buffer_in_[2]);
		ref.refer.data[3] = trajectory_reference[3];
		buffer_in_[3] = (int)(trajectory_reference[3]*norma_float);
		buffer_in_[3] = reverse_word(buffer_in_[3]);
		ref.refer.data[4] = trajectory_reference[4];
		buffer_in_[4] = (int)(trajectory_reference[4]*norma_float);
		buffer_in_[4] = reverse_word(buffer_in_[4]);
		ref.refer.data[5] = trajectory_reference[5];
		buffer_in_[5] = (int)(trajectory_reference[5]*norma_float);
		buffer_in_[5] = reverse_word(buffer_in_[5]);

		send(new_socket, buffer_in_, 32, 0);

		ref.header.stamp = ros::Time::now();
		ref_pub.publish(ref);
		loop_rate.sleep();
  }
}

/// little endian <-> big endian ///////
inline void reverse (int32_t n[3]){
	// int* vector = new int[2]; 
	n[0] = ( ((n[0] & 0x000000FF)<<24) + ((n[0] & 0x0000FF00)<<8) + ((n[0] & 0x00FF0000)>>8) + (( n[0] & 0xFF000000)>>24) );
	n[1] = ( ((n[1] & 0x000000FF)<<24) + ((n[1] & 0x0000FF00)<<8) + ((n[1] & 0x00FF0000)>>8) + (( n[1] & 0xFF000000)>>24) );
	n[2] = ( ((n[2] & 0x000000FF)<<24) + ((n[2] & 0x0000FF00)<<8) + ((n[2] & 0x00FF0000)>>8) + (( n[2] & 0xFF000000)>>24) );
   return;
}

void trajectory_Callback(const std_msgs::Float64MultiArray::ConstPtr& ref_data){
	
	trajectory_reference[0] = ref_data->data[0];
	trajectory_reference[1] = ref_data->data[1];
	trajectory_reference[2] = ref_data->data[2];
	trajectory_reference[3] = ref_data->data[3];
	trajectory_reference[4] = ref_data->data[4];
	trajectory_reference[5] = ref_data->data[5];
	// cout << trajectory_reference[0] << endl;
	// cout << trajectory_reference[1] << endl;
	// cout << trajectory_reference[2] << endl;
	// cout << trajectory_reference[3] << endl;
	// cout << trajectory_reference[4] << endl;
	// cout << trajectory_reference[5] << endl;
}
///////////////////////////////////////

int main(int argc, char **argv){ 
	std::cout << "1" << std::endl;

	bool statado;
	trajectory_reference[0] = 0; trajectory_reference[1] = 0; trajectory_reference[2] = 0; trajectory_reference[3] = 0; trajectory_reference[4] = 0;
	trajectory_reference[5] = 0;

	std::cout << "2" << std::endl;

	// primeira coisa:
	// tem que enviar o arquivo urscript
	send_script(); // a função send_script envia o arquivo para o robô
	std::cout << "3" << std::endl;
	int new_socket = open_socket();
	std::cout << "4" << std::endl;
	float norma_float = 1000000.0;

	//ROS
	ros::init(argc, argv, "ur3");
	boost::thread thread_b(send_data,new_socket);
	ros::NodeHandle node;
	//Declaração das publicões 
	ros::Publisher arm_pub = node.advertise<sensor_msgs::JointState>("arm",10);
	ros::Publisher end_Effector_pub = node.advertise<ur3::end_Effector_msg>("end_effector",10);

	ros::Subscriber sub_demo = node.subscribe("trajectory", 10, trajectory_Callback);
	
	ros::Rate loop_rate(125);
	//Declaração das estruturas de dados para as publicações
	sensor_msgs::JointState arm;
	ur3::end_Effector_msg end_effector;

	arm.header.frame_id = " ";
	arm.name.resize(6);
	arm.position.resize(6);
	arm.velocity.resize(6);
	arm.effort.resize(6); 
	arm.name[0] = "Base";
	arm.name[1] = "Shoulder";
	arm.name[2] = "Elbow";
	arm.name[3] = "Wrist 1";
	arm.name[4] = "Wrist 2";
	arm.name[5] = "Wrist 3";
	
	int32_t vector_arm[3];
	int8_t buffer_out[156]; 
	int b;

	//////////////////////////////////////////////////////////
	
	printf("UR3 is ready!\n");
	
    while (ros::ok()){
		/////////////////////////////////////////////////////
		
		///////////////////////////////////////////////////////////
		b = recv(new_socket, &buffer_out, 156, 0);
		///////////////////////////////////////////////////////////
		//beginning arm 
		memcpy(&vector_arm, &buffer_out[0], 3*sizeof(int32_t));
		reverse(vector_arm);
		arm.position[0] = ((float)vector_arm[0])/norma_float;
		arm.velocity[0] = ((float)vector_arm[1])/norma_float;
		arm.effort[0] = -0.012925*((float)vector_arm[2]);
		//arm.velocity[0] = arm.position[0]/arm.effort[0];
		//printf("%f  %f  %f\n",arm.effort[0],arm.position[0] ,arm.velocity[0]);
		//////////////////////////////////////
		memcpy(&vector_arm, &buffer_out[12], 3*sizeof(int32_t));
		reverse(vector_arm);
		arm.position[1] = ((float)vector_arm[0])/norma_float;
		arm.velocity[1] = ((float)vector_arm[1])/norma_float;
		arm.effort[1] = -0.013088*((float)vector_arm[2]); // 
		// arm.velocity[1] = arm.position[1]/arm.effort[1];
		// printf("%f  %f  %f\n",arm.effort[1],arm.position[1] ,arm.velocity[1]);
		//////////////////////////////////////
		memcpy(&vector_arm, &buffer_out[24], 3*sizeof(int32_t));
		reverse(vector_arm);
		arm.position[2] = ((float)vector_arm[0])/norma_float;
		arm.velocity[2] = ((float)vector_arm[1])/norma_float;
		arm.effort[2] = -0.009358*((float)vector_arm[2]);
		// arm.velocity[2] = arm.position[2]/arm.effort[2];
		// printf("%f  %f  %f\n",arm.effort[2],arm.position[2] ,arm.velocity[2]);
		//////////////////////////////////////////////////////
		memcpy(&vector_arm, &buffer_out[36], 3*sizeof(int32_t));
		reverse(vector_arm);
		arm.position[3] = ((float)vector_arm[0])/norma_float;
		arm.velocity[3] = ((float)vector_arm[1])/norma_float;
		arm.effort[3] = -0.004572*((float)vector_arm[2]);
		// arm.velocity[3] = arm.position[3]/arm.effort[3];
		// printf("%f  %f  %f\n",arm.effort[3],arm.position[3] ,arm.velocity[3]);
		//////////////////////////////////////////////////////
		memcpy(&vector_arm, &buffer_out[48], 3*sizeof(int32_t));
		reverse(vector_arm);
		arm.position[4] = ((float)vector_arm[0])/norma_float;
		arm.velocity[4] = ((float)vector_arm[1])/norma_float;
		arm.effort[4] = -0.004572*((float)vector_arm[2]);
		// arm.velocity[4] = arm.position[4]/arm.effort[4];
		// printf("%f\n",arm.velocity[4]);
		//////////////////////////////////////////////////////
		memcpy(&vector_arm, &buffer_out[60], 3*sizeof(int32_t));
		reverse(vector_arm);
		arm.position[5] = ((float)vector_arm[0])/norma_float;
		arm.velocity[5] = ((float)vector_arm[1])/norma_float;
		arm.effort[5] = -0.004548*((float)vector_arm[2]);
		// arm.velocity[5] = arm.position[5]/arm.effort[5];
		// printf("%f\n",arm.velocity[5]);
		//////////////////////////////////////////////////////
		//end arm
		/////////////////////////////////////////////////
		// beginning gripper
		memcpy(&vector_arm, &buffer_out[72], 3*sizeof(int32_t));
		reverse(vector_arm);
		end_effector.gripper.position = ((float)vector_arm[0])/norma_float;
		end_effector.gripper.max_effort = ((float)vector_arm[1])/norma_float;
		end_effector.state.data = ((float)vector_arm[2])/norma_float;
		/////////////////////////////////////////
		// tcp pose
		////position
		memcpy(&vector_arm, &buffer_out[84], 3*sizeof(int32_t));
		reverse(vector_arm);
		end_effector.pose.position.x = ((float)vector_arm[0])/norma_float;
		end_effector.pose.position.y = ((float)vector_arm[1])/norma_float;
		end_effector.pose.position.z = ((float)vector_arm[2])/norma_float;
		////orientation
		memcpy(&vector_arm, &buffer_out[96], 3*sizeof(int32_t));
		reverse(vector_arm);
		end_effector.pose.orientation.x = ((float)vector_arm[0])/norma_float;
		end_effector.pose.orientation.y = ((float)vector_arm[1])/norma_float;
		end_effector.pose.orientation.z = ((float)vector_arm[2])/norma_float;
		////////////////////////////////////////////////////
		// tcp velocity
		//// linear
		memcpy(&vector_arm, &buffer_out[108], 3*sizeof(int32_t));
		reverse(vector_arm);
		end_effector.velocity.linear.x = ((float)vector_arm[0])/norma_float;
		end_effector.velocity.linear.y = ((float)vector_arm[1])/norma_float;
		end_effector.velocity.linear.z = ((float)vector_arm[2])/norma_float;
		//// angular
		memcpy(&vector_arm, &buffer_out[120], 3*sizeof(int32_t));
		reverse(vector_arm);
		end_effector.velocity.angular.x = ((float)vector_arm[0])/norma_float;
		end_effector.velocity.angular.y = ((float)vector_arm[1])/norma_float;
		end_effector.velocity.angular.z = ((float)vector_arm[2])/norma_float;
		////////////////////////////////////////
		// tcp force
		//// force
		memcpy(&vector_arm, &buffer_out[132], 3*sizeof(int32_t));
		reverse(vector_arm);
		end_effector.wrench.force.x = ((float)vector_arm[0])/norma_float;
		end_effector.wrench.force.y = ((float)vector_arm[1])/norma_float;
		end_effector.wrench.force.z = ((float)vector_arm[2])/norma_float;
		//// torque
		memcpy(&vector_arm, &buffer_out[144], 3*sizeof(int32_t));
		reverse(vector_arm);
		end_effector.wrench.torque.x = ((float)vector_arm[0])/norma_float;
		end_effector.wrench.torque.x = ((float)vector_arm[1])/norma_float;
		end_effector.wrench.torque.x = ((float)vector_arm[2])/norma_float;
		////////////////////////////////////////
		arm.header.stamp = ros::Time::now();
		end_effector.header.stamp = ros::Time::now();
		arm_pub.publish(arm);
		end_Effector_pub.publish(end_effector);
		ros::spinOnce();
		loop_rate.sleep();	
	}
	return 0;
} 


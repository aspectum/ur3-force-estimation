tau = torque_array(fq,fdq,fddq);
std(tau-ftorque, 0, 1)

accel = accel_array(fq,fdq,ftorque);
std(accel-fddq, 0, 1)


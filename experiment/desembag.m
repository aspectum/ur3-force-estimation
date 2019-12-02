clear
clc
root = getenv('root_directory');

%% Loading rosbag
bag = rosbag('ukf1.bag');
msg = readMessages(bag);

%% Unpacking the data

time = zeros(length(msg),1);
Pos1 = zeros(length(msg),1);
Vel1 = zeros(length(msg),1);
T1 = zeros(length(msg),1);
Pos2 = zeros(length(msg),1);
Vel2 = zeros(length(msg),1);
T2 = zeros(length(msg),1);
Pos3 = zeros(length(msg),1);
Vel3 = zeros(length(msg),1);
T3 = zeros(length(msg),1);
Pos4 = zeros(length(msg),1);
Vel4 = zeros(length(msg),1);
T4 = zeros(length(msg),1);
Pos5 = zeros(length(msg),1);
Vel5 = zeros(length(msg),1);
T5 = zeros(length(msg),1);
Pos6 = zeros(length(msg),1);
Vel6 = zeros(length(msg),1);
T6 = zeros(length(msg),1);

for i=1:length(msg)
    time(i) = (msg{i,1}.Header.Stamp.Nsec - msg{1,1}.Header.Stamp.Nsec)/1e9 + (msg{i,1}.Header.Stamp.Sec - msg{1,1}.Header.Stamp.Sec);
    Pos1(i) = msg{i,1}.Position(1,1);
    Vel1(i) = msg{i,1}.Velocity(1,1);
    T1(i) = msg{i, 1}.Effort(1,1);
    Pos2(i) = msg{i,1}.Position(2,1);
    Vel2(i) = msg{i,1}.Velocity(2,1);
    T2(i) = msg{i, 1}.Effort(2,1);
    Pos3(i) = msg{i,1}.Position(3,1);
    Vel3(i) = msg{i,1}.Velocity(3,1);
    T3(i) = msg{i, 1}.Effort(3,1);
    Pos4(i) = msg{i,1}.Position(4,1);
    Vel4(i) = msg{i,1}.Velocity(4,1);
    T4(i) = msg{i, 1}.Effort(4,1);
    Pos5(i) = msg{i,1}.Position(5,1);
    Vel5(i) = msg{i,1}.Velocity(5,1);
    T5(i) = msg{i, 1}.Effort(5,1);
    Pos6(i) = msg{i,1}.Position(6,1);
    Vel6(i) = msg{i,1}.Velocity(6,1);
    T6(i) = msg{i, 1}.Effort(6,1);
end

%% Aggregating the data
% ti = 4.582      si = 572
% t = 14.25       sf = 1781 (1822)

i = 1;
f = length(Pos1);

mt = time(i:f);
mq = [Pos1, Pos2, Pos3, Pos4, Pos5, Pos6];
mq = mq(i:f,:);
mdq = [Vel1, Vel2, Vel3, Vel4, Vel5, Vel6];
mdq = mdq(i:f,:);
mtorque = [T1, T2, T3, T4, T5, T6];
mtorque = mtorque(i:f,:);

save(strcat(root, 'data/ukf1.mat'), "mt", "mq", "mdq", "mtorque");
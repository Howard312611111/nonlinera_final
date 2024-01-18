%state x=[beta row rollrate yalrate]
A_long = [-0.1315,0.14858,0.32434,-0.93964;
    -0,-0,1,0.33976;
    -10.614,0,-1.1793,1.0023;
    0.099655,0,-0.0018174,-0.25855];
%control input u=[aileron rudder]
B_long = [0.00012049,0.00032897;
    0,0;
    -0.1031578,0.020987;
    -0.002133,-0.010715];
C_long = eye(4);
D_long = zeros(5,2);
Ts_sys = 0.01;
Ts_controller = 0.1;
Np = 10;
sys_c = ss(A_long, B_long, C_long, 0);
sys = c2d(sys_c,Ts_sys);

mpcobj_la = mpc(sys, Ts_controller, Np);
mpcobj_la.PredictionHorizon = 15;
mpcobj_la.ControlHorizon = 15;
%set control input constraints
mpcobj_la.ManipulatedVariables(1).Min = -90;
mpcobj_la.ManipulatedVariables(1).Max = 90;
mpcobj_la.ManipulatedVariables(2).Min = -90;
mpcobj_la.ManipulatedVariables(2).Max = 90;
% 设置状态（输出变量）权重Q
mpcobj_la.Weights.OutputVariables = [1 100 10 120];

% 设置控制输入权重R
%mpcobj.Weights.ManipulatedVariables = [10 10];
%Tfinal = 600;  % Simulation time
%r = [0 -30 0 -1.5];   % Setpoint for the outputs
%sim(mpcobj_la, Tfinal, r);
% Open the MPC Designer app for interactive tuning
%mpcDesigner(mpcobj);
% 假设 u、t、x 和 r 是你的控制输入、时间、状态和参考轨迹序列
% Or use review command for a quick look at the controller performance
%review(mpcobj);
%state x=[v_t alpha pitch pitchrate height]
A_long = [-0.38580,18.984,-32.139,0,0.00013233;
    -0.0010280,-0.63253 0.0056129 1 0.0000037553;
    0,0,0,1,0;
    0.000078601,-0.75905,-0.00079341,-0.5183,-0.00000030808;
    -0.043620,-249.76,249.76,0,0];
%control input u=[throttel elevator]
B_long = [10.10,0;
    -0.00015446,0;
    0,0;
    0.024656,-0.010770;
    0,0];
C_long = eye(5);
D_long = zeros(5,2);
Ts_sys = 0.01;
Ts_controller = 0.1;
Np = 10;
sys_c = ss(A_long, B_long, C_long, 0);
sys = c2d(sys_c,Ts_sys);

mpcobj_lo = mpc(sys, Ts_controller, Np);
mpcobj_lo.PredictionHorizon = 10;
mpcobj_lo.ControlHorizon = 10;
x0 = [250;0;0;0;750];
u0 = [0;0];
mpcobj_lo.Model.Nominal = struct('X',x0,'U',u0,'Y',x0);
%set control input constraints
mpcobj_lo.ManipulatedVariables(1).Min = 0;
mpcobj_lo.ManipulatedVariables(1).Max = 1;
mpcobj_lo.ManipulatedVariables(2).Min = -90;
mpcobj_lo.ManipulatedVariables(2).Max = 90;
% 设置状态（输出变量）权重Q
mpcobj_lo.Weights.OutputVariables = [2 120 10 1 1];

% 设置控制输入权重R
mpcobj_lo.Weights.ManipulatedVariables = [0.07 0.02];
%Tfinal = 60;  % Simulation time
%r = [260 0 0 0 730];   % Setpoint for the outputs
%sim(mpcobj_lo, Tfinal, r);
% Open the MPC Designer app for interactive tuning
%mpcDesigner(mpcobj);
% 假设 u、t、x 和 r 是你的控制输入、时间、状态和参考轨迹序列
% Or use review command for a quick look at the controller performance
%review(mpcobj);
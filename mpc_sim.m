f16mpc_la;
f16mpc_lo;
simT = 600;  % Simulation time
r_lo = [250 0 0 0 750];   % remain same height and speed
r_la = [0 30 0 1.57];     % stay at roll=30deg
[y,t,u,xp,xc] = sim(mpcobj_lo, simT, r_lo);
[y2,t2,u2,xp2,xc2]=sim(mpcobj_la, simT, r_la);
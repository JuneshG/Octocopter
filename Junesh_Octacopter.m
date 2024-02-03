clear,
clc,
close all
sim_time = 250;% Simulation time [s]
dt = 0.01;% Simulation time step length [s]

g = 9.81;%Gravity [m/s^2]
m = 4.34;% Quadrotor mass
b = 1.2953*1e-5;% Thrust coefficient [Ns^2]
l = 0.315;% Rotor arm length [m]
d = 0.008;% Reaction torque coefficient [m]
Ixx = 0.0820;% Moment of inertia along x axis [kg m^2]
Iyy = 0.0845;% Moment of inertia along y axis [kg m^2]
Izz = 0.1377;% Moment of inertia along z axis [kg m^2]

%Controller Gains
%Preleminary values. 

Kpx = 0.3;
Kdx = 0.50;
Kpy = 0;
Kdy = 0.15;

Kiz = 15;
Koz = 1;
Kozi = 0;
 
Kip = 2;
Kop = 5;
Kopi = 0;
 
Kiq = 2;
Koq = 5;
Koqi = 0;
 
Kir = 2.2;
Kor = 1;
Kori = 0;

sim_res = sim('Octacopter.slx');
time = sim_res.tout;% Retrieve time vector

%Unpack state variables
x = sim_res.X(:,1);
y = sim_res.X(:,2); 
z = sim_res.X(:,3);
u = sim_res.X(:,4);
v = sim_res.X(:,5);
w = sim_res.X(:,6);
p = sim_res.X(:,7);
q = sim_res.X(:,8);
r = sim_res.X(:,9);
phi = sim_res.X(:,10);
theta = sim_res.X(:,11);
psi = sim_res.X(:,12);


%Unpack commanded variables
z_c = sim_res.X_ref(:,1);
Phi_c = sim_res.X_ref(:,2);
Theta_c = sim_res.X_ref(:,3);
Psi_c = sim_res.X_ref(:,4);
% 
%Unpack space trajectories
X = sim_res.XYZ(:,1);
Y = sim_res.XYZ(:,2);
Z = sim_res.XYZ(:,3);

Xc = sim_res.XYZc(:,1);
Yc = sim_res.XYZc(:,2);
Zc = sim_res.XYZc(:,3);

%Generate plots
plot(time,[z_c,z]),grid,xlabel('time [s]'),legend('z_d[m]','z_a [m]'),title("Altitude Maneuver")
figure(2),
plot(time,[Phi_c,phi]*180/pi),grid,xlabel('time[s]'),legend('Phi_d [deg]','Phi_a [deg]'),title("Roll Maneuver")
figure(3),
plot(time,[Theta_c,theta]*180/pi),grid,xlabel('time[s]'),legend('Theta_d [deg]','Theta_a [deg]'),title("Pitch Maneuver")
figure(4),
plot(time,[Psi_c,psi]*180/pi),grid,xlabel('time[s]'),legend('Psi_d [deg]','Psi_a [deg]'),title("Yaw Maneuver")
figure(5),
plot(time,[Xc X]),grid,xlabel('time [s]'),...
legend('X_c [m]', 'X [m]'),title('X - Component ')
figure(6),
plot(time,[Yc Y]),grid,xlabel('time [s]'),...
legend('Y_c [m]', 'Y [m]'),title('Y - Component ')
figure(7),
plot(time,[Zc Z]),grid,xlabel('time [s]'),...
legend('Z_c [m]', 'Z [m]'),title('Z - Component ')
figure(8),
plot3([X Xc], [Y Yc] , [Z Zc] ),grid,legend('Drone path','Commanded path'),title('3D Maneuver')
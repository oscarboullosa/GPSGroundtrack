clear;
format long;

%% Data
% Obtain TLE data
TLE_Data = TLE_Matrix_From_File("Group_17.tle");

% Constants
G = 6.67384e-11;  % Gravitational Constant
M = 5.972e24;     % Earth mass
AngSpeedEarth = 7.2921151467e-5;  % Angular speed of Earth rotation

%% Ground track of a LEO satellite

%Parameters

i_o = deg2rad(str2double(TLE_Data(2,3))); % Orbit inclination [rad]
Omega_o_dos_prima = deg2rad(str2double(TLE_Data(2,4))); % Right ascension of the ascending node at ToA [rad]
e =  str2double(TLE_Data(2,5))/10^7; % Orbit eccentricity
w = deg2rad(str2double(TLE_Data(2,6))); % Argument of the perigee at ToA [rad]
M_o = deg2rad(str2double(TLE_Data(2,7))); % Mean anomaly at ToA [rad]
n = str2double(TLE_Data(2,8))*2*pi/(3600*24); % Satellite mean motion [rad/s]
a = (G*M/n^2)^1/3; % Semi-major axis [m]
t0 = str2double(eraseBetween(TLE_Data(1,4),1,2));
[esec, GASTdeg, tgdate] = time2toa(t0,18,9,2023,20,18,12);
Omega_o = Omega_o_dos_prima - deg2rad(GASTdeg);  % Longitude of the ascending node at the ToA [rad]
Omega_o_punto = 0;
TimePeriod = 2*pi/n;


% Load world map data
Map = load('world_110m.txt');

% Plot world map
plot(Map(:, 1), Map(:, 2), '.');
hold on;
title('Ground Track Iridium 126');
TimeInterval = 10; %Refresh each TimeInterval seconds


for t = esec:TimeInterval:(esec+TimePeriod)
    dt = t-t0 ;
    % Compute ECEF coordinates
    [x, y, z] = Kepler2ECEF(a, i_o, e, Omega_o, Omega_o_punto, w, M_o, n, dt);
    % Convert ECEF to LLA
    [h, latitude, longitude] = ECEF2LLA([x, y, z]);
    latitudeDeg=rad2deg(latitude);
    longitudeDeg=rad2deg(longitude);
    % Plot satellite position in red
    plot(rad2deg(longitude), rad2deg(latitude), "r.");
    hold on;
end
hold off;


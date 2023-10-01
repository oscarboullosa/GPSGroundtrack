clear;

% Obtain almanac data
[baseweek, esec, NS, Eph] = almanac();
[numRows, numColumns] = size(Eph);

% Constants
G = 6.67384e-11;  % Gravitational Constant
M = 5.972e24;     % Earth mass
AngSpeedEarth = 7.2921151467e-5;  % Angular speed of Earth rotation

% Current time
t = esec;

% Satellite selection and relevant parameters
satellite = 1;
t0 = Eph(satellite, 4);  % ToA from the almanac
dt = t - t0;
sqrt_a = Eph(satellite, 7);  % Square root of the semi-major axis
a = sqrt_a^2;  % Semi-major axis
n = sqrt((G * M) / a^3);  % Mean motion
Omega_o_prima = Eph(satellite, 8);  % Longitude of the ascending node at the GPS week epoch
w = Eph(satellite, 9);  % Argument of the perigee at ToA
Omega_o = Omega_o_prima - AngSpeedEarth * t0;  % Longitude of the ascending node at the ToA
M_o = Eph(satellite, 10);
i_o = Eph(satellite, 5);
e = Eph(satellite, 3);

% Compute ECEF coordinates
[x, y, z] = Kepler2ECEF(a, i_o, e, Omega_o, Omega_o_prima, w, M_o, n, dt);

% Convert ECEF to LLA
[h, latitude, longitude] = ECEF2LLA([x, y, z]);
latitudeDeg=rad2deg(latitude);
longitudeDeg=rad2deg(longitude);
% Load world map data
Map = load('world_110m.txt');

% Plot world map
plot(Map(:, 1), Map(:, 2), '.');
hold on;

% Plot satellite position in red
plot(rad2deg(longitude), rad2deg(latitude), '+');
hold on;

% Display satellite number
text(rad2deg(longitude + 0.1), rad2deg(latitude + 0.05), sprintf('%d', Eph(satellite, 1)));

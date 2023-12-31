clear;

% Obtain almanac data
[baseweek, esec, NS, Eph] = almanac();
[numRows, numColumns] = size(Eph);

% Constants
G = 6.67384e-11;  % Gravitational Constant
M = 5.972e24;     % Earth mass
AngSpeedEarth = 7.2921151467e-5;  % Angular speed of Earth rotation

% Map data
Map = load("world_110m.txt");

% Set the time range and interval
start_time = esec;  % Start time in seconds
end_time = esec + 3600;  % End time in seconds 60 min
time_interval = 20;  % Interval of 20 seconds


% Plot the map
plot(Map(:, 1), Map(:, 2), '.');
hold on;

% Iterate over each satellite
for satellite = 1:31
    aux=0;
    % Iterate over the specified time range with the given interval
    for t = start_time:time_interval:end_time
        % Satellite selection and relevant parameters
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
        Omega_o_punto=Eph(satellite,6);
        
        % Compute ECEF coordinates
        [x, y, z] = Kepler2ECEF(a, i_o, e, Omega_o, Omega_o_punto, w, M_o, n, dt);
        
        % Convert ECEF to LLA
        [h, latitude, longitude] = ECEF2LLA([x, y, z]);
        latitudeDeg = rad2deg(latitude);
        longitudeDeg = rad2deg(longitude);
        
        % Plot satellite position in red
        plot(rad2deg(longitude), rad2deg(latitude), '.');
        hold on;
        
        % Display satellite number
            
          if(aux<1)
                text(rad2deg(longitude + 0.05), rad2deg(latitude + 0.05), sprintf('%d', Eph(satellite, 1)));
                aux=aux+1;
            end  
         
    end

end

xlabel('Longitude (degrees)');
ylabel('Latitude (degrees)');
title('Satellite Positions');

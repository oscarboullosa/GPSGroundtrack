function[x,y,z] = Kepler2ECEF(a,i_o,e,Omega_o,Omega_o_punto,w,M_o,n,dt)
    AngSpeedEarth = 7.2921151467e-5;  % Angular speed of Earth rotation
    
    % Calculate Omega_k once and keep it constant
    Omega_k = Omega_o + Omega_o_punto * dt - AngSpeedEarth * dt;  % Convertir a radianes
    
    M_k = M_o + n * dt;  % Current mean anomaly
    error = 100;
    aux = 1;
    E_k(aux) = M_k;
    
    while(error >= 10e-8)  % Iterative solution
        aux = aux + 1;
        E_k(aux) = M_k + e * sin(E_k(aux-1));
        error = abs(E_k(aux) - E_k(aux-1));
    end
    
    E_k = E_k(aux);  % Current eccentric anomaly
    sin_vk = sin(((sqrt(1 - e^2)) * sin(E_k)) / (1 - e * cos(E_k)));
    cos_vk = (cos(E_k) - e) / (1 - e * cos(E_k));
    v_k = atan2(sin_vk, cos_vk);  % True anomaly without ambiguity
    u_k = v_k + w;  % Argument of latitude
    r_k = a * (1 - e * cos(E_k));  % Orbit radius
    
    x_p = r_k * cos(u_k);  % x coordinate within the orbital plane
    y_p = r_k * sin(u_k);  % y coordinate within the orbital plane
    

    x = x_p * cos(Omega_k) - y_p * cos(i_o) * sin(Omega_k);  % ECEF x-coordinate
    y = x_p * sin(Omega_k) + y_p * cos(i_o) * cos(Omega_k);  % ECEF y-coordinate
    z = y_p * sin(i_o);  % ECEF z-coordinate
end

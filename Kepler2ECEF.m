function[x,y,z] = Kepler2ECEF(a,i_o,e,Omega_o,Omega_o_Prima,w,M_o,n,dt)
    Omega_e_prima = 7.2921151467*10^(-5);
    M_k = M_o + n * dt;
    error = 1;
    E_temp = M_k;
    while(error>= 10e-8)
       E_k = M_k + e*sin(E_temp);
       error = abs(E_k - E_temp);
       E_temp = E_k;
    end
    sin_vk = sqrt(1-e^2)*sin(E_k)/(1-e*cos(E_k));
    cos_vk = (cos(E_k)-e)/(1-e*cos(E_k));
    v_k = atan2( sin_vk,cos_vk);
    u_k = v_k + w;
    r_k = a * (1 - e * cos(E_k));
    Omega_k = Omega_o + Omega_o_Prima * dt - Omega_e_prima * dt;
    x_p = r_k * cos(u_k);
    y_p = r_k * sin(u_k);
    
    
    x = x_p * cos(Omega_k) - y_p*cos(i_o) * sin(Omega_k);
    y = x_p * sin(Omega_k) + y_p*cos(i_o) * cos(Omega_k);
    z = y_p * sin(i_o);


end

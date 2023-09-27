function [h,Phi,Lambda] = ECEF2LLA(x,y,z)

a = 6378137;
e = sqrt(0.0066943799014);
c = e*a;
b = sqrt(a^2-c^2);
e_prima = c/b;

r = sqrt(x^2+y^2);
E = sqrt(a^2 - b^2);
F = 54*b^2*z^2;
G = r^2 + (1-e^2)*z^2 - e^2*E^2;
C = (e^4*F*r^2)/ (G^3);
s=nthroot((1+C+(sqrt(C^2+2*c))),3);
%s =(1+ C + sqrt(C^2+ 2*C))^(1/3);
P = F / (3*(s+(1/s)+1)^2*G^2);
Q = sqrt(1+2*e^4*P);
r_o = (-P*e^2*r)/(1+Q) + sqrt(1/2*a^2*(1+(1/Q))- (P*(1-e^2)*z^2/(Q*(1+Q)))-1/2*P*r^2);
U = sqrt(z^2 + (r-r_o*e^2)^2);
V = sqrt(z^2*(1-e^2) + (r-r_o*e^2)^2);
z_o = (b^2*z)/(a*V);

h = U*(1-(b^2/(a*V)));
Phi = atan((z+e_prima^2*z_o)/r);
Lambda = atan(y/x);
end

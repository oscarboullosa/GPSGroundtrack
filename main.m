[baseweek, esec, NS, Eph] = almanac();
[numRows,numColumns]=size(Eph);
G=6.67384e-11;%Gravitational Constant
M=5.972e24;%Earth mass
AngSpeedEarth=7.2921151467e-5;
t=esec;
t0=Eph(2,4);
dt=t-t0;%Tiempo actual tuyo desde el inicio de la semana menos la semana
sqrta=Eph(2,7);%Matriz de la raiz del semieje mayor
a=sqrta^2;%Semieje mayor
n=sqrt((G*M)/a^3);%Mean motion
Omega_o=Eph(2,8);
w=Eph(2,9);
Omega_o_Prima=Eph(2,8)-AngSpeedEarth*t0;
M_o=Eph(2,10);
i_o=Eph(2,5);
e=Eph(2,3);
[x,y,z] = Kepler2ECEF(a,i_o,e,Omega_o,Omega_o_Prima,w,M_o,n,dt);
[h,Phi,Lambda] = ECEF2LLA(x,y,z);
Latitud=rad2deg(Phi);
Longitud=rad2deg(Lambda);
Map=load("world_110m.txt");
plot(Map(:,1),Map(:,2),'.');
hold on;
plot(Longitud,Latitud,'*');

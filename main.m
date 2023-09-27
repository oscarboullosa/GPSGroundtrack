clear;
[baseweek, esec, NS, Eph] = almanac();
[numRows,numColumns]=size(Eph);
G=6.67384e-11;%Gravitational Constant
M=5.972e24;%Earth mass
AngSpeedEarth=7.2921151467e-5;%Angular speed of Earth rotation
t=esec;%Tiempo actual
t0=Eph(2,4);%ToA del almanac
dt=t-t0;%Diferencia de tiempo entre el ToA y el tiempo actual
sqrt_a=Eph(2,7);%Matriz de la raiz del semieje mayor
a=(sqrt_a)^2;%Semieje mayor
n=sqrt((G*M)/a^3);%Mean motion
Omega_o_prima=Eph(2,8);%Longitude of the ascending node at the GPS week wpoch
w=Eph(2,9);%Argument of the perigee at ToA
Omega_o=Omega_o_prima-AngSpeedEarth*t0;%Longitude of the ascending node at the ToA
M_o=Eph(2,10);
i_o=Eph(2,5);
e=Eph(2,3);
[x,y,z,aux] = Kepler2ECEF(a,i_o,e,Omega_o,Omega_o_prima,w,M_o,n,dt);
array=aux;
[h,Phi,Lambda] = ECEF2LLA(x,y,z);
Latitud=rad2deg(Phi);
Longitud=rad2deg(Lambda);
Map=load("world_110m.txt");
plot(Map(:,1),Map(:,2),'.');
hold on;
plot(Longitud,Latitud,'*');
hold on;
text(Longitud+2,Latitud+1,sprintf('%d',Eph(2,1)));

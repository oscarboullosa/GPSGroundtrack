% compute UTC time and date from Julian Date (algorithm from Richards -see Wikipedia-)

function [HH, mm, ss, secfrac, dow, D, M, Y] = UTCfromJD(JD)

dowlist = ['Mon'; 'Tue'; 'Wed'; 'Thu'; 'Fri'; 'Sat'; 'Sun'];

y = 4716;
j = 1401;
m = 2;
n = 12;
r = 4;
p = 1461;
v = 3;
u = 5;
s = 153;
w = 2;
B = 274277;
C = -38;

J = round(JD);
f = J + j;
f = f + fix((fix((4 * J + B)/146097) * 3)/4) + C;
e = r * f + v;
g = fix(mod(e, p)/r);
h = u * g + w;
D = fix((mod(h, s))/u) + 1;
M = mod(fix(h/s) + m, n) + 1;
Y = fix(e/p) - y + fix((n + m - M)/n);

if(JD > J)
  esec = (JD - J) * 86400;			% between noon and midnight: compute elapsed seconds since last noon
  HH = fix(esec/3600);
  mm = fix((esec - HH * 3600)/60);
  ss = fix(esec - HH * 3600 - mm * 60);
  secfrac = esec - HH * 3600 - mm * 60 - ss;
  HH = HH + 12;
else
  esec = (0.5 - (J - JD)) * 86400;		% between midnight and noon: compute elapsed seconds since last midnight
  HH = fix(esec/3600);
  mm = fix((esec - HH * 3600)/60);
  ss = fix(esec - HH * 3600 - mm * 60);
  secfrac = esec - HH * 3600 - mm * 60 - ss;
end

dow = dowlist(fix(mod(JD + 0.5, 7)) + 1, 1:3);

end

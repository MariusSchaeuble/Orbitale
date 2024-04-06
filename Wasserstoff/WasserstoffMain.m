n = 4;
l = 3;
m = 2;
a0 = 5.291772109e-11;


f = 100; %feinheit
g = 10^(-8.5);
%{
2 9
4 8.5
5 8.5

%}
d = linspace(-g, g, f);
[x, y, z] = meshgrid(d, d, d);
r = sqrt(x.^2 + y.^2 + z.^2);
theta = acos(z./r);
phi = arrayfun(@(x, y) phi2pi(x, y), x, y);

N = n + zeros(size(x));
L = l + zeros(size(x));
M = m + zeros(size(x));

psi = arrayfun(@(N, L, M, phi, theta, r) getPsiO(N, L, M, phi, theta, r), N, L, M, phi, theta, r);
xs = x;
ys = y;
zs = z;
%polynome
%legendre
x = cos(theta);
mAbs = abs(m);
res = 0;
val = zeros((l+2)*(mAbs+l+1)+3, 3);
c = 1;
for u=0:l
    val(c, 1) = nchoosek(l, u);
    val(c, 2) = (-1)^(l-u);
    val(c, 3) = 2*u;
    c = c+1;
end
for j=1:mAbs+l
    c0 = c-1;
    for k=1:c0
        if (val(k, 1) ~= 0)
            if (val(k, 3)>0)
                val(c, 3) = val(k, 3)-1;
                val(c, 1) = val(k, 1)*val(k, 3);
                val(c, 2) = val(k, 2);
                c = c+1;
            end
            val(k, 1) = 0; %altes auslöschen            
        end
    end
end
%einsetzen
for k=1:c-1
    if (val(k, 1) ~= 0)
        res = res + val(k, 1)*val(k, 2)*x.^val(k, 3);
    end
end
res = res/(factorial(l));
res = res/(2^l);
res = res.*(1-x.^2).^(mAbs/2);
psi = psi.*res;
%laguerre
x = 2*r/(n*a0);
nf = n+l;
mf = 2*l+1;
res = 0;
val = zeros(2, 3);
val(1, 1) = 1; %vorfaktor
val(1, 2) = 1; %vorzeichen
val(1, 3) = nf; %exponent
c = 2; %nächster freier index
for j=1:nf
    c0 = c-1;
    for k=1:c0
        if (val(k, 1) ~= 0)
            if (val(k, 3)>0)
                val(c, 3) = val(k, 3)-1;
                val(c, 1) = val(k, 1)*val(k, 3);
                val(c, 2) = val(k, 2);
                c = c+1;
                val(c, :) = [0, 0, 0];
                val(c, 3) = val(k, 3);
                val(c, 1) = val(k, 1);
                val(c, 2) = -1*val(k, 2);
                c = c+1;
                val(c, :) = [0, 0, 0];

            else
                val(c, 3) = 0;
                val(c, 1) = val(k, 1);
                val(c, 2) = -1*val(k, 2);
                c = c+1;
                val(c, :) = [0, 0, 0];

            end
            val(k, 1) = 0; %altes auslöschen            
        end
    end
end
%nochmals m mal ableiten, n>m
for j=1:mf
    c0 = c-1;
    for k=1:c0
        if (val(k, 1) ~= 0)
            if (val(k, 3)>0)
                val(c, 3) = val(k, 3)-1;
                val(c, 1) = val(k, 1)*val(k, 3);
                val(c, 2) = val(k, 2);
                c = c+1;
                val(c, :) = [0, 0, 0];
            end
            val(k, 1) = 0; %altes auslöschen            
        end
    end
end
%einsetzen
for k=1:c-1
    if (val(k, 1) ~= 0)
        res = res + val(k, 1)*val(k, 2)*x.^val(k, 3);
    end
end
psi = psi.*res;
psisq = abs(psi.^2);
dV = (2*g/(f-1))^3;
%{
s = isosurface(xs, ys, zs, psisq);
iso = zeros(30, 1);
for k=1:30
    x = s.vertices(k, 1);
    y = s.vertices(k, 2);
    z = s.vertices(k, 3);
    r = x^2 + y^2 + z^2;
    theta = acos(z/r);
    phi = phi2pi(x, y);
    iso(k) = abs(getPsi(n, l, m, phi, theta, r))^2;
end
%}
iso = mean(mean(mean(psisq)))*5;
m1 = ( psisq>iso ) ;
m2 = psisq.*m1;
p = sum(dV*m2, "all");

isosurface(xs, ys, zs, psisq, iso , sign(psi));
axis equal;
title("p = " + num2str(p) + " ,    bei " + num2str(sum(m1, "all")) + " messpunkten im orbital");



%}








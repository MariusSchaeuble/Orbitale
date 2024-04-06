function res = getPsi(n, l, m, phi, theta, r)
a0 = 5.291772109e-11;
res = 1/sqrt(2*pi);
res = res*sqrt(  (2*l+1)*factorial(l-abs(m))  /   ((2)*(factorial(l+abs(m))))   );
res = res*legendre3(cos(theta), l, m);
res = res*exp(1i*m*phi);

res = -1*res*sqrt(factorial(n-l-1)/(2*n*(factorial(n+l))^3));
res = res*(2/(n*a0))^1.5;
res = res*(2*r/(n*a0))^l;
res = res*exp(-1*r/(n*a0));
res = res*laguerre3(2*r/(n*a0), n+l, 2*l+1);
end
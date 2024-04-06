function res = legendre2(x, l, m)
m = abs(m);
res = 1/(factorial(l));
res = res/(2^l);
syms a;
f = diff((a^2-1)^l, l+m);
a = x;
res = res*subs(f);
res = res*(1-x^2)^(m/2);
end
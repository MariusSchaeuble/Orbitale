function res = laguerre2(x, n, m)
syms a;
f = diff(exp(a)*diff(a^n*exp(-a), n), m);
a = x;
res = double(subs(f));
end
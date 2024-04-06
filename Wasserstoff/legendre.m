function res = legendre(x, l, m)
m = abs(m);
res = 1/(factorial(l));
res = res/(2^l);
str = "eval(diff((x^2-1)^";
str = str + num2str(l);
str = str +  ", [x$";
str = str +  num2str(l+m);
str = str + "]), x = ";
str = str + num2str(x);
str = str + ")";
res = res*double(maple(str));
res = res*(1-x^2)^(m/2);
end
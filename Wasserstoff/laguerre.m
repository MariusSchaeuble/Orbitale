function res = laguerre(x, n, m)
str = "eval(diff(exp(x)*diff(x^";
str = str + num2str(n);
str = str + "*exp(-x), [x$";
str = str + num2str(n);
str = str + "]), [x$";
str = str + num2str(m);
str = str + "]), x = ";
str = str + num2str(x);
str = str + ")";
res = double(maple(str));
end
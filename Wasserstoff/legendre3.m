function res = legendre3(x, l, m)
m = abs(m);
res = 0;
val = zeros((l+2)*(m+l+1)+3, 3);
c = 1;
for u=0:l
    val(c, 1) = nchoosek(l, u);
    val(c, 2) = (-1)^(l-u);
    val(c, 3) = 2*u;
    c = c+1;
end
for j=1:m+l
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
        res = res + val(k, 1)*val(k, 2)*x^val(k, 3);
    end
end
res = res/(factorial(l));
res = res/(2^l);
res = res*(1-x^2)^(m/2);
end
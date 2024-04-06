function res = laguerre3(x, n, m)
res = 0;
val = zeros(2*(n+1)*2^(n+1)+3, 3);
val(1, 1) = 1; %vorfaktor
val(1, 2) = 1; %vorzeichen
val(1, 3) = n; %exponent
c = 2; %nächster freier index
for j=1:n
    c0 = c-1;
    for k=1:c0
        if (val(k, 1) ~= 0)
            if (val(k, 3)>0)
                val(c, 3) = val(k, 3)-1;
                val(c, 1) = val(k, 1)*val(k, 3);
                val(c, 2) = val(k, 2);
                c = c+1;
                val(c, 3) = val(k, 3);
                val(c, 1) = val(k, 1);
                val(c, 2) = -1*val(k, 2);
                c = c+1;

            else
                val(c, 3) = 0;
                val(c, 1) = val(k, 1);
                val(c, 2) = -1*val(k, 2);
                c = c+1;

            end
            val(k, 1) = 0; %altes auslöschen            
        end
    end
end
%nochmals m mal ableiten, n>m
for j=1:m
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
end
function res = phi2pi(x, y)
if (x>0 && y>=0)
    res = atan(y/x);
    return;
end
if(x>0 && y<0)
    res = atan(y/x) + 2*pi;
    return;
end
if (x<0)
    res = atan(y/x) + pi;
    return;
end
res = 0;
end
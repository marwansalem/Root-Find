function [xr , table_results] =fixed_point(g,x,eps,max_iter)
i=1;
xr=feval(g,x);
if xr ==x 
    return;
end
ea = 999;
table_results = [ ];
while ea>eps && i+1<=max_iter
    i=i+1;
    x=xr;
    xr=feval(g,x);
    ea = abs((x-xr)/xr);
    table_results = [table_results; xr ea];
end
end

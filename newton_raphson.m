function [xr,table_results] = newton_raphson(func_str,x_0,eps,max_iter)
syms x;
f = inline(func_str);
g(x) = diff(sym('func_str')); %  g(x) = diff is not correct
%
xi = x_0;
xr = xi;
table_results = [];
%% p
for i = 1:1: max_iter
    
    f_dash = g(xi);
    xr = xi - f(xi)/sym2poly(f_dash); % need to convert sym to num
    if xr == Inf || xr == -Inf;
        xr = xi;
        break;
    end
    ea = abs((xr-xi)/xr)
    if xr == 0 && xi ==0 
        table_results = [table_results; xi 0];
        return;
    end
    table_results = [table_results; xi ea];
    if ea < eps;
        break;
    end
    xi = xr;
end
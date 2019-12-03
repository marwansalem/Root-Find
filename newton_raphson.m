function [xr,table_results] = newton_raphson(func_str,x_0,eps,max_iter,single_step)
syms x;
f = inline(func_str);
g(x) = diff(sym(func_str)); %  g(x) = diff is not correct
%
xi = x_0;
xr = xi;
table_results = [];
if(single_step);
    fprintf('i        xi           ea\n');
end
%% p
for i = 1:1: max_iter
    
    f_dash = g(xi);
    if f_dash ==0 || isnan(f(xi));
        fprintf('Wrong Input division by zero in funcction');
        return
    end
    xr = xi - f(xi)/sym2poly(f_dash); % need to convert sym to num
    if xr == Inf || xr == -Inf;
        xr = xi;
        break;
    end
    ea = abs((xr-xi)/xr);
    if xr == 0 && xi ==0 ;
        table_results = [table_results; xi 0];
        return;
    end
    table_results = [table_results; xi ea];
    if(single_step);
        fprintf('%4i      %f      %f\n', i-1, xi, ea);
        choice = questdlg('Next or Skip?','Single Step Mode','Next','Skip to end','Next');
        if strcmp(choice,'Skip to end');
            single_step = 0;
        end
    end
    if ea < eps;
        break;
    end
    xi = xr;
end
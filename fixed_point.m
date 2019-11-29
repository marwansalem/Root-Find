function [xr , table_results] =fixed_point(g,x,eps,max_iter,single_step)
i=1;
xr=feval(g,x);
if xr ==x 
    return;
end
ea = 999;
table_results = [ ];
if single_step;
    fprintf('i  xr            ea  \n');
end
while ea>eps && i+1<=max_iter
    i=i+1;
    x=xr;
    xr=feval(g,x);
    ea = abs((x-xr)/xr);
    if(single_step);
        fprintf('%4i %f     %f \n', i-1, xr, ea);
        choice = questdlg('Next or Skip?','Single Step Mode','Next','Skip to end','Next');
        if strcmp(choice,'Skip to end');
            single_step = 0;
        end
    end
    table_results = [table_results; xr ea];
end
end

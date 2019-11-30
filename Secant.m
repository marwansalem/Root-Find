% Secant Method in MATLAB
function [x, i, table_results] = Secant(f,x_0,x_1,eps,max_iter,single_step)
 
if x_0 == x_1 
    disp('secant guesses must be different')
    table_results = -1;
    x = [];
    i = 1;
    return
end
x(1)=x_0;
x(2)=x_1;

table_results = [];
root = intmax;
xr = root;
iteration=0;



if(single_step);
    fprintf('   i        xi-1          xi          f(xi)       f(xi-1)       xr           ea\n');
end
last_idx = intmax;

for i=3:max_iter
    x(i) = x(i-1) - (f(x(i-1)))*((x(i-1) - x(i-2))/(f(x(i-1)) - f(x(i-2))));
    iteration=iteration+1;
    xr = x(i);
    if( xr == Inf || xr ==-Inf);
        fprintf('Error division by zero');
        xr = x(i-1);% previous errors
    end
    ea= abs((x(i)-x(i-1))/x(i));
    if x(i) == 0 && x(i-1) == 0
        table_results = [table_results; x(i-2) x(i-1) f(x(i-2)) f(x(i-1)) x(i) 0];
        return
    end
    table_results = [table_results; x(i-2) x(i-1) f(x(i-2)) f(x(i-1)) x(i) ea];
    if(single_step);
        fprintf('%4i %f     %f      %f      %f       %f       %f \n', i-1, x(i-2), x(i-1), f(x(i-2)), f(x(i-1)), x(i), ea);
        choice = questdlg('Next or Skip?','Single Step Mode','Next','Skip to end','Next');
        if strcmp(choice,'Skip to end');
            single_step = 0;
        end
    end
    if abs((x(i)-x(i-1))/x(i))<eps;
        root=x(i);
        xr = root;
        iteration=iteration;
        break
    end
end
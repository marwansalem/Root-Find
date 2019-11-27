% Secant Method in MATLAB
function [xr, table_results] = Secant(f,x_0,x_1,eps,max_iter)
 
x(1)=x_0;
x(2)=x_1;

table_results = [];
root = intmax;
xr = root;
iteration=0;

fprintf('x \t\t     error \n');
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
    table_results = [table_results; x(i-2) x(i-1) f(x(i-2)) f(x(i-1)) x(i) ea];
    fprintf('%f \t %f \n',x(i),ea);
    if abs((x(i)-x(i-1))/x(i))<eps;
        root=x(i);
        xr = root;
        iteration=iteration;
        break
    end
end
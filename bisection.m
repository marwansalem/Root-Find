% Bisection Method
%%Basem Gaber
%% ID: 4826
function xr = bisection(f,xl,xu,eps,max_iter)


if (f(xl) * f(xu) > 0) % if guesses do not bracket, exit
    disp('no bracket')
    return
end

ea=999;
disp('Iter low         high            x0         ea');
for i=1:1:max_iter
    xr=(xu+xl)/2; % compute the midpoint xr
    xrList(i)=xr; % add midpount to list of all midpoints
    if(i>1)
        ea = abs((xrList(i)-xrList(i-1))/xrList(i)); % approx. relative error = current approx - prev approx / current approx
    end
    fprintf('%4i %f \t %f \t %f \t %f \n', i-1, xl, xu, xr, ea);
    test= f(xl) * f(xr); % compute f(xl)*f(xr)
    if (test < 0) 
        xu=xr;
    else 
        xl=xr;
    end

    if (test == 0) 
        ea=0; 
    end
    if (ea < eps) 
        break; 
    end
end

s=sprintf('\n Root= %f #Iterations = %d \n', xr,i); disp(s);

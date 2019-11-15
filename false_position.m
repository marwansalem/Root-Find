% False Position Method
%%Basem Gaber
%% ID: 4826

function xr = false_position(f,xl,xu,eps,max_iter)
% a=input('Enter function with right hand side zero:','s');
% f=inline(a);
% xl=input('Enter the first value of guess interval:') ;
% xu=input('Enter the end value of guess interval:');
% es=input('Enter the allowed error:');
% imax=input('Enter the max allowed iterations:');

if (f(xl) * f(xu) > 0) % if guesses do not bracket, exit
    disp('no bracket')
    return
end

ea=999;
disp('Iter low         high            xr         ea');
for i=1:1:max_iter
    xr=((xl*f(xu)) - (xu*f(xl))) / (f(xu) - f(xl)) ; % compute the midpoint xr
    %xr = xu - ( ( (f(xu)) * (xl-xu) ) / (f(xl) - f(xu)) );
    xrList(i)=xr; % add midpount to list of all midpoints
    if(i>1)
        ea = abs((xrList(i)-xrList(i-1))/xrList(i)); % approx. relative error = current approx - prev approx / current approx
    end
    fprintf('%4i %f \t %f \t %f \t %f \n', i-1, xl, xu, xr, ea);
    %fprintf("%f \t %f\n",f(xl),f(xu));
    test= f(xr)*f(xu); % compute f(xr)
    if (test < 0) 
        xl=xr;
    else
        xu=xr;
    end

    if (test == 0) 
        ea=0; 
    end
    if (ea < eps) 
        break; 
    end
end

s=sprintf('\n Root= %f #Iterations = %d \n', xr,i); disp(s);

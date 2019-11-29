% Bisection Method
%%Basem Gaber
%% ID: 4826
function [xrList,i,table_results] = bisection(f,xl,xu,eps,max_iter,single_step)


xr = intmax;
if (f(xl) * f(xu) > 0) % if guesses do not bracket, exit
    disp('no bracket')
    table_results = -1;
    return
end

ea=999;
table_results = [ ];
if(single_step);
    fprintf('   i\t\t  xl\t\t        xu\t\t xr\t\t\t   ea \n');
end

%disp('Iter low         high            x0         ea');
for i=1:1:max_iter
    xr=(xu+xl)/2; % compute the midpoint xr
    
    xrList(i)=xr; % add midpount to list of all midpoints
    if(i>1);

        ea = abs((xrList(i)-xrList(i-1))/xrList(i)); % approx. relative error = current approx - prev approx / current approx
        table_results = [table_results; xl xu xr ea f(xr)];
    else
        table_results = [ table_results; xl xu xr NaN f(xr)];
    end
    if(single_step);
        fprintf('%4i %f \t %f \t %f \t %f \n', i-1, xl, xu, xr, ea);
        choice = questdlg('Next or Skip?','Single Step Mode','Next','Skip to end','Next');
        if strcmp(choice,'Skip to end');
            single_step = 0;
        end
    end
    test= f(xl) * f(xr); % compute f(xl)*f(xr)
    if (test < 0); 
        xu=xr;
    else 
        xl=xr;
    end

    if (test == 0); 
        ea=0; 
    end
    if (ea < eps) ;
        break; 
    end
end

s=sprintf('\n Root= %f #Iterations = %d \n', xr,i); disp(s);

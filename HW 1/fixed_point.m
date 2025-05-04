%format longG
function[x_, fx_, n_itr, err_abs] = fixed_point(f, x_0, tlr, n_max)

%initialize output arguments
x_= []; fx_= []; n_itr = []; err_abs = [];

%fixed point iteration
for i=1:n_max
    x_ = [x_;x_0]; %update the fixed point array
    %x_1 = f(x_0); %formula for fixed point iterate
    x_1 = feval(f, x_0); %formula for fixed point iterate, i.e., $x_1 = f(x_0)$
    fx_ = [fx_; x_1]; %update the array for function of fixed point
    n_itr = [n_itr; i]; %update the array for no. of iterations
    err_abs = [err_abs; abs(x_1 - x_0)]; %update the array for absolute error
    fprintf("After iteration no. %d, x_%d = %0.4f \n", i, i, x_1);
    if abs(x_1 - x_0) < tlr %alternatively, g(x_1) == x_1
        fprintf("Convergence reached at %dth iteration\n", i);
        break;
    else
        fprintf("Convergence not reached\n");
    end
    x_0 = x_1; %update the fixed point
end
return
end
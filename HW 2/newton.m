function[x_, fx_, n_itr, err_abs] = newton(f, x_0, tlr, n_max)

%initialize output arguments
x_= []; fx_= []; n_itr = []; err_abs = [];

f_x = matlabFunction(diff(sym(f))); %first derivative

for i=1:n_max
    if feval(f_x, x_0) == 0
        fprintf("Division by zero. Choose a different initial guess, or method.\n");
        break;
    else
        x_ = [x_;x_0]; %update the array for iterate
        x_1 = x_0 - feval(f, x_0)/feval(f_x, x_0); %newton iteration formula
        fx_ = [fx_; x_1]; %update the array for function
        n_itr = [n_itr; i]; %update the array for no. of iterations
        err_abs = [err_abs; abs(x_1 - x_0)]; %update the array for absolute error
        fprintf("After iteration no. %d, x_%d = %0.9f \n", i, i, x_1);
        if abs(x_1 - x_0) < tlr 
            fprintf("Convergence reached at iteration no. %d\n", i);
            break;
        else
            fprintf("Convergence not reached\n");
        end
    x_0 = x_1;
    end
end
return
end
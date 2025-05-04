function[x_, fx_, n_itr, err_abs] = newton_mu(f, x_0, tlr, n_max)

%initialize output arguments
x_= []; fx_= []; n_itr = []; err_abs = [];

f_x = matlabFunction(diff(sym(f))); %first derivative of $f(x)$
mu = matlabFunction(sym(f)/sym(f_x)); %$\mu(x) = \frac{f(x)}{f'(x)}$
mu_x = matlabFunction(diff(sym(mu))); %first derivative of $\mu(x)$

for i=1:n_max
    if feval(mu_x, x_0) == 0
        fprintf("Division by zero. Choose a different initial guess, or method.\n");
        break;
    else
        x_ = [x_;x_0]; %update the array for iterate
        x_1 = x_0 - feval(mu, x_0)./feval(mu_x, x_0); %newton iteration formula
        fx_ = [fx_; x_1]; %update the array for function
        n_itr = [n_itr; i]; %update the array for no. of iterations
        err_abs = [err_abs; abs(x_1 - x_0)]; %update the array for absolute error
        fprintf("After iteration no. %d, x_%d = %g \n", i, i, x_1);
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
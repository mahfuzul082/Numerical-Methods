function[x_, fx_, n_itr, err_abs] = chord(f, a, b, tlr, n_max)

%initialize output arguments
x_= []; fx_= []; n_itr = []; err_abs = [];

x_0 = (a+b)./2; %initial guess
m = (b - a)./ (feval(f, b) - feval(f, a)); %slope

for i=1:n_max
    if feval(f, a) == 0
        fprintf("After iteration no. %d, x_%d = %0.9f.\nConvergence reached at iteration no. %d.", i, i, a, i);
        break;
    elseif feval(f, b) == 0
        fprintf("After iteration no. %d, x_%d = %0.9f.\nConvergence reached at iteration no. %d.", i, i, b, i);
        break;
    elseif feval(f, a)*feval(f, b) > 0
        fprintf("Choose different initial guesses.\n");
        break;
    elseif (feval(f, b) - feval(f, a)) == 0
        fprintf("Division by zero. Choose a different initial guess, or method.\n");
    else
        x_ = [x_; x_0]; %update the array for iterate
        fx = feval(f, x_0);
        fx_ = [fx_; fx]; %update the array for function
        x_1 = x_0 - m.*feval(f, x_0); %chord iteration formula
        n_itr = [n_itr; i]; %update the array for no. of iterations
        err_abs = [err_abs; abs(x_1 - x_0)]; %update the array for absolute error
        fprintf("After iteration no. %d, x_%d = %0.9f \n", i, i, x_0)
        if abs(x_1 - x_0) < tlr
            fprintf("Convergence reached at iteration no. %d \n", i);
            break;
        else
            fprintf("Convergence not reached\n");
        end
        x_0 = x_1;
    end
end
return
end
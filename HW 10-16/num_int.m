function int = num_int(f, a, b, n, method)

switch method
    case 'm'
        h = (b - a)./n;
        x_ = a + (0.5:1:n-0.5)*h;
        fx_ = f(x_);
        int = h*sum(fx_);
        fprintf("Integral using midpoint rule is: %g\n", int);
    case 't'
        h = (b-a)./n;
        x_ = linspace(a, b, n+1);
        fx_ = f(x_);
        int = h/2*(fx_(1) + 2*sum(fx_(2:end-1)) + fx_(end));
        fprintf("Integral using trapezoidal rule is: %g\n", int);
    case 's'
        if rem(n, 2) ~= 0
            error("n must be even for Simpson's rule. Choose an even n.");
        end
        h = (b-a)./n;
        x_ = linspace(a, b, n+1);
        fx_ = f(x_);
        int = h/3*(fx_(1) + 4*sum(fx_(2:2:end-1)) + 2*sum(fx_(3:2:end-2)) + fx_(end));
        fprintf("Integral using Simpson's rule is: %g\n", int);
end
end
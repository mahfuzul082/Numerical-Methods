function [p] = lagrange (f, a, b, nn)

syms x;
x_ = linspace(a, b, nn); % node values
y_ = feval(f, x_); % f(x_) values
p = 0;

for i = 1:nn
    l_i = ones(size(x));
    for j = 1:nn
        if(j ~= i)
            l_i = l_i.*(x - x_(j))./(x_(i) - x_(j)); % lagrange basis formula 
        end
    end
    p = p + y_(i).*l_i; % polynomial value at each point
end
p = vpa(expand(p));
fprintf("Lagrange polynomial is P_%d = \n", length(x_)-1);
disp(p);
return
end
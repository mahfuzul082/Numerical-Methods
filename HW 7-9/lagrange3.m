function [l_sum, p_n] = lagrange (f, a, b, nn, np)

x_ = linspace(a, b, nn); % node values
y_ = feval(f, x_); % f(x_) values
x = linspace(a, b, np); % points in [a, b]
p_n = zeros(size(x)); % initializing interpolated polynomial values
l_sum = zeros(size(x)); % initializing summation of basis 

for i = 1:nn
    l_i = ones(size(x));
    for j = 1:nn
        if(j ~= i)
            l_i = l_i.*(x - x_(j))./(x_(i) - x_(j)); % lagrange basis formula 
        end
    end
    l_sum = l_sum + l_i; % summing basis at each point
    p_n = p_n + y_(i).*l_i; % polynomial value at each point
end

for i = 1:length(x)
fprintf("Polynomial value, P(%g) = %g\n", x(i), p_n(i));
end
return
end
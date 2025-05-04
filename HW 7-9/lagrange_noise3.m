function [p_n] = lagrange_noise (f, a, b, nn, np, n_level)

syms x;
x_ = linspace(a, b, nn); % node values

% adding noise to f(x)
rng(2);
r = a + (b-a).*rand(1, nn);
noise = (n_level * r);
y_n = feval(f, x_) + noise;

x = linspace(a, b, np); % points in [a, b]
p_n = 0;

for i = 1:nn
    l_i = ones(size(x));
    for j = 1:nn
        if(j ~= i)
            l_i = l_i.*(x - x_(j))./(x_(i) - x_(j)); % lagrange basis formula
        end
    end
    l_sum = l_sum + l_i; % summing basis at each point
    p_n = p_n + y_n(i).*l_i; % polynomial value at each point
end

for i = 1:length(x)
fprintf("Polynomial value, P(%g) = %g\n", x(i), p_n(i));
end
return
end
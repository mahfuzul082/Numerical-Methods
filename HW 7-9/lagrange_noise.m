function [p_n] = lagrange_noise (f, a, b, nn, n_level)

syms x;
x_ = linspace(a, b, nn); % node values

% adding noise to f(x)
rng(2);
r = a + (b-a).*rand(1, nn);
noise = (n_level * r);
y_n = feval(f, x_) + noise;
p_n = 0;

for i = 1:nn
    l_i = ones(size(x));
    for j = 1:nn
        if(j ~= i)
            l_i = l_i.*(x - x_(j))./(x_(i) - x_(j)); % lagrange basis formula
        end
    end
    p_n = p_n + y_n(i).*l_i; % polynomial value at each point
end
p_n = vpa(expand(p_n));
fprintf("Lagrange polynomial for polluted data is P_%d = \n", length(x_)-1);
disp(p_n);
return
end
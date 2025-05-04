clear all; clc;
format longG;

n = 100; % no. of equispaced distance
np = 1000; % no. of interpolating points
x = -1:2/np:1; % interpolating points in interval [-1, 1]
lambda_x = zeros(1, n); % initializing lebesgue constant

for l = 1:n
    x_ = -1:2/l:1; % node values
    l_sum = zeros(size(x)); % initializing summation of lagrange basis
    for i = 1:length(x_)
        l_i = ones(size(x));
        for j = 1:length(x_)
            if(j ~= i)
                l_i = l_i.*(x - x_(j))./(x_(i) - x_(j)); % lagrange basis formula 
            end
        end
        l_sum = l_sum + abs(l_i); % summing basis at each point
    end
    lambda_x(l) = max(l_sum); %computing lebesgue constant
end

% asymptotic bound
t = [];
for i = 1:n
    tt = 2.^(i+1)./(i.*log(i));
    t = [t; tt];
end

% plots
fig1 = figure(1); semilogy([1:n], lambda_x, 'b', 'LineWidth', 1.5, 'DisplayName','$\Lambda_n(X_n)$'); hold on;
semilogy([1:n], t, 'r', 'LineWidth', 1.5, 'DisplayName','$\frac{2^{n+1}}{nlogn}$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'northwest', 'interpreter', 'latex');
xlabel('\textit{x}', 'interpreter', 'latex');
ylabel('\textit{y}', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig1,'lebesgue.pdf');

fig2 = figure(2); plot([1:n], lambda_x, 'b', 'LineWidth', 1.5, 'DisplayName','$\Lambda_n(X_n)$'); hold on;
plot([1:n], t, 'r', 'LineWidth', 1.5, 'DisplayName','$\frac{2^{n+1}}{nlogn}$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'northwest', 'interpreter', 'latex');
xlabel('\textit{x}', 'interpreter', 'latex');
ylabel('\textit{y}', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig2,'lebesgue2.pdf');
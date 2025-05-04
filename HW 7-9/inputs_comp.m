clear all; clc;
format longG
f = @(x) sin(22*pi*x); % function
a = -1; % lower limit of interval
b = 1; % upper limit of interval
nn = 100; % no. of nodes
np = 10000; % no. of points
n_level = 9.5e-4; % noise level
f_x = f(linspace(a, b, np));

%% w/o noise
[l_sum, p_n] = lagrange(f, a, b, nn, np);
p_n1 = p_n;

%% w/ noise
[l_sum, p_n, y_n] = lagrange_noise(f, a, b, nn, np, n_level);
p_n2 = p_n;

%% polynomial plot
i4 = figure(4); fplot (f, [-1, 1], 'b', 'LineWidth', 1.5, 'DisplayName','$f(x)$'); hold on;
plot (linspace(a, b, np), p_n1, 'r--', 'LineWidth', 1.5, 'DisplayName','$P_{99}(x)$'); hold on;
plot (linspace(a, b, np), p_n2, "-.", "Color", "#2E6F40", 'LineWidth', 1.5, 'DisplayName','$\widetilde P_{99}(x)$'); hold on;
scatter (linspace(a, b, nn), feval(f, linspace(a, b, nn)), 30, "ko", 'filled', 'DisplayName','$(x, f(x))$'); hold off;
xlim([-1 1]); 
ylim ([-2 2]);
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('NumColumns', 2, 'Location', 'north', 'interpreter', 'latex');
xlabel('\textit{x}', 'interpreter', 'latex');
ylabel('\textit{y}', 'interpreter', 'latex', 'FontSize', 13);
pbaspect([4 2.3 1]);
saveas(i4,'interpol4.pdf');

i5 = figure(5); semilogy(linspace(a, b, np), abs(f_x), 'b', 'LineWidth', 1.5, 'DisplayName','$|f(x)|$'); hold on;
semilogy(linspace(a, b, np), abs(p_n1), 'r--', 'LineWidth', 1.5, 'DisplayName','$|P_{99}(x)|$'); hold on;
semilogy(linspace(a, b, np), abs(p_n2), "-.", "Color", "#2E6F40", 'LineWidth', 1.5, 'DisplayName','$|\widetilde P_{99}(x)|$'); hold off;
%scatter (linspace(a, b, nn), feval(f, linspace(a, b, nn)), 30, "ko", 'filled', 'DisplayName','$(x, f(x))$'); hold off;
xlim([-1 1]);
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'north', 'interpreter', 'latex', 'FontSize', 11);
xlabel('\textit{x}', 'interpreter', 'latex');
ylabel('$|y|$', 'interpreter', 'latex');
pbaspect([1.4 1 1]);
saveas(i5,'interpol5.pdf');

%% derivative plot
i6 = figure(6);
legend_prop={};
for n = 10:10:100
    f_x = matlabFunction(diff(sym(f),n));
    semilogy(linspace(a, b, nn), abs(f_x(linspace(a, b, nn))),'LineWidth',1.5);hold on;
    legend_prop{end+1}= ['$f^{' num2str(n) '}$'];   
end 
hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend(legend_prop, 'NumColumns', 5, 'Location','Northeast', 'interpreter', 'latex');
ylim ([1 1e225]); 
xlabel('\textit{x}', 'interpreter', 'latex');
ylabel('$|y|$', 'interpreter', 'latex');
%pbaspect([2 1 1]);
saveas(i6,'interpol6.pdf');
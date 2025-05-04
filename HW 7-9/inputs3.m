clear all; clc;
format longG
f = @(x) sin(22*pi*x); % function
a = -1; % lower limit of interval
b = 1; % upper limit of interval
nn = 22; % no. of nodes
np = 1000; % no. of points
n_level = 9.5e-4; % noise level

%% w/o noise
[p_n] = lagrange(f, a, b, nn, np);

i1 = figure(1); fplot (f, [-1, 1], 'b', 'LineWidth', 1.5, 'DisplayName','$f(x) = sin(22\pi x)$'); hold on;
plot (linspace(a, b, np), p_n1, 'r--', 'LineWidth', 1.5, 'DisplayName','$P_{21}(x)$'); hold on;
scatter (linspace(a, b, nn), feval(f, linspace(a, b, nn)), 60, "ko", 'filled', 'DisplayName','$(x, f(x))$'); hold off;
ylim ([-1.5 1.5]);
set(gca,'TicklabelInterpreter','latex','FontSize', 12);
legend('boxoff');
legend('NumColumns', 3,'Location', 'northwest', 'interpreter', 'latex');
xlabel('\textit{x}', 'interpreter', 'latex');
ylabel('\textit{y}', 'interpreter', 'latex');
pbaspect([4 2 1]);
saveas(i1,'interpol1.pdf');

%% w/ noise
[l_sum, p_n, y_n] = lagrange_noise(f, a, b, nn, np, n_level);
p_n2 = p_n;
error_noise = max(abs(f_x - p_n2));

i2 = figure(2); fplot (f, [-1, 1], 'b', 'LineWidth', 1.5, 'DisplayName','$f(x) = sin(22\pi x)$'); hold on;
plot (linspace(a, b, np), p_n2, 'r--', 'LineWidth', 1.5, 'DisplayName','$\widetilde P_{21}(x)$'); hold on;
scatter (linspace(a, b, nn), y_n, 60, "ko", 'filled', 'DisplayName','$(x, \widetilde f(x))$'); hold off;
%ylim ([-1.5 1.5]);
set(gca,'TicklabelInterpreter','latex','FontSize', 12);
legend('boxoff');
legend('NumColumns', 3,'Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{x}', 'interpreter', 'latex');
ylabel('\textit{y}', 'interpreter', 'latex');
pbaspect([4 2 1]);
saveas(i2,'interpol2.pdf');

%% error comparison
i3 = figure(3);
plot (linspace(a, b, np), abs(p_n1-p_n2), 'b', 'LineWidth', 1.5); hold off;
%ylim ([-1.5 1.5]);
set(gca,'TicklabelInterpreter','latex','FontSize', 12);
xlabel('\textit{x}', 'interpreter', 'latex');
ylabel('$|P_{21}(x) - \widetilde P_{21}(x)|$', 'interpreter', 'latex', 'FontSize', 12);
pbaspect([4 2 1]);
saveas(i3,'interpol3.pdf');
fprintf("Interpolation error:\nw/o noise = %g,  w/ noise = %g,  difference = %g\n", ...
    error, error_noise, max(abs(p_n1 - p_n2)));
clear all; clc;
format longG
f = @(x) sin(22*pi*x); % function
a = -1; % lower limit of interval
b = 1; % upper limit of interval
nn = 22; % no. of nodes
np = linspace(-1, 1, 100); % no. of points
n_level = 9.5e-4; % noise level

%% w/o noise
[p] = lagrange(f, a, b, nn);
p = subs(p, np);
[p_n] = lagrange_noise(f, a, b, nn, n_level);
p_n = subs(p_n, np);

i7 = figure(7); fplot (f, 'b', 'LineWidth', 1.5, 'DisplayName','$f(x) = sin(22\pi x)$'); hold on;
plot (np, p, 'r--', 'LineWidth', 1.5, 'DisplayName','$P_{21}(x)$'); hold on;
plot (np, p_n, "-.", "Color", "#2E6F40", 'LineWidth', 1.5, 'DisplayName','$\widetilde P_{21}(x)$'); hold on;
scatter (linspace(a, b, nn), f(linspace(a, b, nn)), 60, "ko", 'filled', 'DisplayName','$(x, f(x))$'); hold off;
xlim([-1 1]); 
%ylim ([-2 2]);
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('NumColumns', 2, 'Location', 'south', 'interpreter', 'latex');
xlabel('\textit{x}', 'interpreter', 'latex');
ylabel('\textit{y}', 'interpreter', 'latex', 'FontSize', 13);
pbaspect([4 2.3 1]);
saveas(i7,'interpol7.pdf');

%% error comparison
i3 = figure(3);
plot (np, abs(p-p_n), 'b', 'LineWidth', 1.5); hold off;
%ylim ([-1.5 1.5]);
set(gca,'TicklabelInterpreter','latex','FontSize', 12);
xlabel('\textit{x}', 'interpreter', 'latex');
ylabel('$|P_{21}(x) - \widetilde P_{21}(x)|$', 'interpreter', 'latex', 'FontSize', 12);
pbaspect([4 2 1]);
saveas(i3,'interpol3.pdf');

%% derivative plot
i6 = figure(6);
legend_prop={};
for n = 1:1:22
    f_x = matlabFunction(diff(sym(f),n));
    semilogy(linspace(a, b, nn), abs(f_x(linspace(a, b, nn))),'LineWidth',1.5);hold on;
    legend_prop{end+1}= ['$f^{' num2str(n) '}$'];   
end 
hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend(legend_prop, 'NumColumns', 5, 'Location','south', 'interpreter', 'latex');
%ylim ([1 1e225]); 
xlabel('\textit{x}', 'interpreter', 'latex');
ylabel('$|y|$', 'interpreter', 'latex');
%pbaspect([2 1 1]);
saveas(i6,'interpol6.pdf');
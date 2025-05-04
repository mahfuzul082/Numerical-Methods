clear all; clc;

format longG
%input arguments
syms x;
f = @(x) x - x.^5;
x_0 = 1;
tlr = 1.e-10;
n_max = 3000;

%call the fixed point iteration function
[x_, fx_, n_itr, err_abs] = fixed_point(f, x_0, tlr, n_max);
[x_, fx_, n_itr, err_abs];

x_e = fzero(@(x) x.^5, x_0)
x_err = abs(x_e - x_);

%plot the output arguments
g1 = figure(1); plot(n_itr, x_, 'r--+', 'LineWidth', 1.5, 'DisplayName','$x_n$'); hold on;
plot(n_itr, fx_, 'b-o', 'LineWidth', 1.5, 'DisplayName','$g_2(x_n)$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northwest', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n');
ylabel('$x_n$, $g_2(x_n)$');
%ylim ([0 0.5]);
pbaspect([1 1 1]);
%saveas(g1,'gg1_0.5.pdf');

g2 = figure(2);
semilogy(n_itr, err_abs, 'r--+', 'LineWidth', 1.5, 'DisplayName','$\left|x_n - x_{n-1}\right|$'); hold on;
semilogy(n_itr, x_err, 'b-o', 'LineWidth', 1.5, 'DisplayName','$\left|x_e - x_n\right|$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northwest', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n');
ylabel('$\left|x_{error}\right|$');
pbaspect([1 1 1]);
%saveas(g2,'gg2_0.5.pdf');
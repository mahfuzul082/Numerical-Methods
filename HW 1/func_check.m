clear all; clc;

syms x;
f1 = x - x.^5;
f1_x = diff(f1, x);
f2 = x + x.^5;
f2_x = diff(f2, x);

h1 = figure(3); fplot(@(x) x, [-1.1 1.1], 'r-', 'LineWidth', 1.5, 'DisplayName','$y = x$'); hold on; 
fplot(f1, [-1.1 1.1], 'b-', 'LineWidth', 1.5, 'DisplayName','$y = g_1(x) = x - x^5$'); hold on; 
fplot(f1_x, [-1.1 1.1], 'm-.', 'LineWidth', 1.5, 'DisplayName','$y = g''_1(x) = 1 - 5x^4$'); hold off;
rectangle('Position',[-1 -1 2 2], 'LineStyle', '--', 'LineWidth', 1); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'south', 'interpreter', 'latex');
xlabel('$x$');
ylabel('$y$');
%legend on;
%set(gca, 'TickLabelInterpreter','latex', legend);
pbaspect([1 1 1]);
saveas(h1,'f1.pdf');

h2 = figure(4); fplot(@(x) x, [-1.1 1.1], 'r-', 'LineWidth', 1.5, 'DisplayName','$y = x$'); hold on; 
fplot(f2, [-1.1 1.1], 'b-', 'LineWidth', 1.5, 'DisplayName','$y = g_2(x) = x + x^5$'); hold on; 
fplot(f2_x, [-1.1 1.1], 'm-.', 'LineWidth', 1.5, 'DisplayName','$y = g''_2(x) = 1 + 5x^4$'); hold off;
rectangle('Position',[-1 -1 2 2], 'LineStyle', '--', 'LineWidth', 1); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'north', 'interpreter', 'latex');
xlabel('$x$');
ylabel('$y$');
%legend on;
%set(gca, 'TickLabelInterpreter','latex', legend);
pbaspect([1 1 1]);
saveas(h2,'f2.pdf');
clear all; clc;

%syms x;
f1 = @(x) x - x.^5;
%f1_x = diff(f1, x);
f2 = @(x) x + x.^5;
%f2_x = diff(f2, x);
x_0 = [0];
y_0 = [0];

h1 = figure(3); fplot(@(x) x, [-1 1], 'r-', 'LineWidth', 1.5, 'DisplayName','$y = x$'); hold on; 
fplot(f1, [-1 1], 'b-', 'LineWidth', 1.5, 'DisplayName','$y = g_1(x)$'); hold on;
plot(x_0, y_0, 'k.', 'MarkerSize', 20, 'DisplayName', '$(x, y) = (0, 0)$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'northwest', 'interpreter', 'latex');
xlabel('$x$');
ylabel('$y$');
%legend on;
%set(gca, 'TickLabelInterpreter','latex', legend);
pbaspect([1 1 1]);
saveas(h1,'fxd1.pdf');

h2 = figure(4); fplot(@(x) x, [-1 1], 'r-', 'LineWidth', 1.5, 'DisplayName','$y = x$'); hold on; 
fplot(f2, [-1 1], 'b-', 'LineWidth', 1.5, 'DisplayName','$y = g_2(x)$'); hold on;
plot(x_0, y_0, 'k.', 'MarkerSize', 20, 'DisplayName', '$(x, y) = (0, 0)$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'northwest', 'interpreter', 'latex');
xlabel('$x$');
ylabel('$y$');
%legend on;
%set(gca, 'TickLabelInterpreter','latex', legend);
pbaspect([1 1 1]);
saveas(h2,'fxd2.pdf');

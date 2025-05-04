clear all; clc;

syms x;
f = piecewise(x >= -pi & x < 0, -1, x >= 0 & x < pi, 1); %function
s_2 = 4/pi*sin(x); %approximation $n=2$
s_3 = 4/pi*sin(x); %approximation $n=3$

fig1 = figure(1);
fplot(f, 'k', 'LineWidth', 1.5, 'DisplayName', '$f(x)$'); hold on;
fplot(s_2, 'b', 'LineWidth', 1.5, 'DisplayName', '$S_2(x)$'); hold on;
fplot(s_3, 'r', 'LineWidth', 1.5, 'DisplayName', '$S_3(x)$'); hold off;
set(gca,'XTick', [-pi 0 pi], 'XTickLabel',{'$-\pi$','0','$\pi$'},'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'southeast', 'interpreter', 'latex');
xlabel('$x$', 'interpreter', 'latex');
ylabel('$y$', 'interpreter', 'latex');
xlim([-pi pi]);
ylim([-1.5 1.5]);
pbaspect([1 1 1]);
saveas(fig1,'trig_poly.pdf');
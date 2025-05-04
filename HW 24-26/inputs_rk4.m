clear all; clc;

format longG;

f = @(t, x) 6.22e-19*(2e3-x./2).^2*(2e3-x./2).^2*(3e3-3*x./4).^3; %ODE
t_i = 0; %initial $t$
t_f = 0.2; %final $t$

h_ = [];
x_ = [];
for h = [1e-2 5e-3 1e-3 5e-4 1e-4 5e-5 1e-5 5e-6 1e-6] %time-step sizes
    [t, x] = runge_kutta4(f, t_i, h, t_f); %function call
    h_ = [h_; h];
    x_ = [x_; x(end)];
end

fig7 = figure(7);
semilogx(h_, x_, 'k-o', 'LineWidth', 1.5); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
xlabel('$h$', 'interpreter', 'latex');
ylabel('\textit{Units of} $KOH$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig7,'r-k4.pdf');
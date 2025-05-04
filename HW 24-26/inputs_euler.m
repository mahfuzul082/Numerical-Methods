clear all; clc;

format longG;

f = @(t, y) t.^(-2)*(sin(2.*t)-2.*t.*y); %ODE
t_i = 1; %initial $t$
h = 0.25; %step size
t_f = 2; %final $t$

[t, y] = ForwardEuler(f, t_i, h, t_f); %function call
t_ = t;
y_ = y;

f_ = @(t) 1./(2.*t.^2).*(4+cos(2)-cos(2.*t)); %exact solution

fig1 = figure(1);
fplot (f_, [1, 2], 'r-', 'LineWidth', 1.5, 'DisplayName', '\textit{Exact}'); hold on;
plot(t, y, 'b-o', 'LineWidth', 1.5, 'DisplayName', '\textit{Forward Euler}'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('$t_i$', 'interpreter', 'latex');
ylabel('$\omega_i$', 'interpreter', 'latex');
pbaspect([1 0.8 1]);
saveas(fig1,'f_euler.pdf');

%%error estimation
err = abs(f_(t)-y); %actual error
syms t; syms y;
L = matlabFunction(diff(f,y));
M = matlabFunction(diff(f_,t,2));

fig2 = figure(2);
fplot(abs(sym(L)), [1 2], 'r-', 'LineWidth', 1.5, 'DisplayName', '$\left|\frac{\partial f(t, y)}{\partial y}\right|$'); hold on;
fplot(abs(sym(M)), [1 2], 'b-', 'LineWidth', 1.5, 'DisplayName', '$\left|y''''(t)\right|$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('$t$', 'interpreter', 'latex');
ylabel('$\left|\frac{\partial f(t, y)}{\partial y}\right|$, $\left|y''''(t)\right|$', 'interpreter', 'latex');
pbaspect([1 0.8 1]);
saveas(fig2,'l_m.pdf');

L_ = max(abs(L(linspace(t_i, t_f, 1000)))); %computing $L$
M_ = max(abs(M(linspace(t_i, t_f, 1000)))); %computing $M$
err_theo = [];
for i = 1:length(t_)
    if L_ == 0
        fprintf("Division by zero. No bound found.\n");
        break;
    else
        err_theo_ = abs(h.*M_./(2.*L_).*(exp(L_.*(t_(i)-t_i))-1)); %theoretical error bound formula
        err_theo = [err_theo;err_theo_]
    end
end
fig3 = figure(3);
plot(t_, err_theo, 'r-o', 'LineWidth', 1.5, 'DisplayName', '\textit{Theoretical error bound}'); hold on;
plot(t_, err, 'b-o', 'LineWidth', 1.5, 'DisplayName', '\textit{Actual error}'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'northwest', 'interpreter', 'latex');
xlabel('$t_i$', 'interpreter', 'latex');
ylabel('$\left|y_i - \omega_i\right|$', 'interpreter', 'latex');
pbaspect([1 0.8 1]);
saveas(fig3,'f_euler_err.pdf');
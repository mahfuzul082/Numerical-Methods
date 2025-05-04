clear all; clc;

format longG;

syms t y(t);
f = t^(-2)*(sin(2*t)-2*t*y); %ODE
t_i = 1; %initial $t$
t_f = 2; %final $t$

f_ = matlabFunction(1/(2*t^2)*(4+cos(2)-cos(2*t))); %exact solution

%%second order
h = 0.25; %time-step size
order = '2';
[t_o, y_o] = Taylor(f, t_i, h, t_f, order); %function call
t_o2 = t_o;
y_o2 = y_o;
err_o2_ = abs(f_(t_o2)-y_o2); %actual error

h_o2 = [];
err_o2_arr = [];
for h = 2.^(-1:-1:-10)
    [t_o, y_o] = Taylor(f, t_i, h, t_f, order); %function call
    err_o2 = max(abs(f_(t_o)-y_o)); %maximum actual error for different $h$
    h_o2 = [h_o2; h];
    err_o2_arr = [err_o2_arr; err_o2];
end

%%fourth order
h = 0.25; %time-step size
order = '4';
[t_o, y_o] = Taylor(f, t_i, h, t_f, order);
t_o4 = t_o;
y_o4 = y_o;
err_o4_ = abs(f_(t_o4)-y_o4)

h_o4 = [];
err_o4_arr = [];
for h = 2.^(-1:-1:-10)
    [t_o, y_o] = Taylor(f, t_i, h, t_f, order); %function call
    err_o4 = max(abs(f_(t_o)-y_o)); %maximum actual error for different $h$
    h_o4 = [h_o4; h];
    err_o4_arr = [err_o4_arr; err_o4];
end

%%plots
fig4 = figure(4);
fplot(f_, [1 2], 'k-', 'LineWidth', 1.5, 'DisplayName', '\textit{Exact}'); hold on;
plot (t_o2, y_o2, 'r-o','LineWidth', 1.5, 'DisplayName', '\textit{Taylor''s} 2\textit{nd order}'); hold on;
plot(t_o4, y_o4, 'b-o', 'LineWidth', 1.5, 'DisplayName', '\textit{Taylor''s} 4\textit{th order}'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('$t_i$', 'interpreter', 'latex');
ylabel('$\omega_i$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig4,'taylor.pdf');

fig5 = figure(5);
semilogy(t_o2, err_o2_, 'r-o','LineWidth', 1.5, 'DisplayName', '\textit{Taylor''s} 2\textit{nd order}'); hold on;
semilogy(t_o4, err_o4_, 'b-o', 'LineWidth', 1.5, 'DisplayName', '\textit{Taylor''s} 4\textit{th order}'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'southeast', 'interpreter', 'latex');
xlabel('$t_i$', 'interpreter', 'latex');
ylabel('$\left|y_i - \omega_i\right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig5,'taylor_err.pdf');

fig6 = figure(6);
loglog(h_o2, err_o2_arr, 'r-o','LineWidth', 1.5, 'DisplayName', '\textit{Taylor''s} 2\textit{nd order}'); hold on;
loglog(h_o4, err_o4_arr, 'b-o', 'LineWidth', 1.5, 'DisplayName', '\textit{Taylor''s} 4\textit{th order}'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'southeast', 'interpreter', 'latex');
xlabel('$h$', 'interpreter', 'latex');
ylabel('$\max\limits_{1 \leq t \leq2}\left(\left|y_i - \omega_i\right|\right)$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig6,'taylor_err_h.pdf');
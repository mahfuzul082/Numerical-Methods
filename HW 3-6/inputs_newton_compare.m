clear all; clc;
format longG

%input arguments
f = @(x) exp(x) - x - 1;
x_0 = 1;
tlr = 1.e-10;
n_max = 30;

%call the original newton function
[x_, fx_, n_itr, err_abs] = newton(f, x_0, tlr, n_max);
[x_, fx_, n_itr, err_abs];
x_errn = abs(0 - x_);
o_n =(log(x_errn(3:end))-log(x_errn(2:end-1)))./(log(x_errn(2:end-1)) - log(x_errn(1:end-2)));

%call the modified newton function
[x_, fx_, n_itr, err_abs] = newton_mu(f, x_0, tlr, n_max);
[x_, fx_, n_itr, err_abs];
x_errnm = abs(0 - x_);
o_nm =(log(x_errnm(3:end))-log(x_errnm(2:end-1)))./(log(x_errnm(2:end-1)) - log(x_errnm(1:end-2)));

%plot convergence order
g3 = figure(3); 
plot([3:length(o_n)+2], o_n, 'r--+', 'LineWidth', 1.5, 'DisplayName','$f(x)$'); hold on;
plot([3:length(o_nm)+2], o_nm, 'b-o', 'LineWidth', 1.5, 'DisplayName','$\mu(x)$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$\alpha$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g3,'order_nc.pdf');

%plot difference in logarithmic error
g4 = figure(4);
loglog(abs(x_errn(2:end-1) - x_errn(1:end-2)), abs(x_errn(3:end) - x_errn(2:end-1)), 'r--+', 'LineWidth', 1.5, 'DisplayName','$f(x)$'); hold on;
loglog(abs(x_errnm(2:end-1) - x_errnm(1:end-2)), abs(x_errnm(3:end) - x_errnm(2:end-1)), 'b-o', 'LineWidth', 1.5, 'DisplayName','$\mu(x)$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'northwest', 'interpreter', 'latex');
xlabel('$log\left|x_{n} - x_e\right| - log\left|x_{n-1} - x_e\right|$', 'interpreter', 'latex');
ylabel('$log\left|x_{n+1} - x_e\right| - log\left|x_{n} - x_e\right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g4,'de_nc.pdf');
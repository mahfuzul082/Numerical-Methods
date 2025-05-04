clear all; clc;
format longG

%input arguments
f = @(x) exp(x) - x - 1;
x_0 = 1;
tlr = 1.e-10;
n_max = 30;

%call the function
[x_, fx_, n_itr, err_abs] = newton_mu(f, x_0, tlr, n_max);
[x_, fx_, n_itr, err_abs];
x_errn = abs(0 - x_);
o_n =(log(x_errn(3:end))-log(x_errn(2:end-1)))./(log(x_errn(2:end-1)) - log(x_errn(1:end-2)));

%plot the iterates, and function values
g1 = figure(1); 
plot(n_itr, x_, 'r--+', 'LineWidth', 1.5, 'DisplayName','$x_n$'); hold on;
plot(n_itr, fx_, 'b-o', 'LineWidth', 1.5, 'DisplayName','$f(x_n)$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$x_n$, $f(x_n)$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g1,'f_nm.pdf');

%plot error
g2 = figure(2);
semilogy(n_itr, err_abs, 'r--+', 'LineWidth', 1.5, 'DisplayName','$\left|x_n - x_{n-1}\right|$'); hold on;
semilogy(n_itr, x_errn, 'b-o', 'LineWidth', 1.5, 'DisplayName','$\left|x_e - x_n\right|$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$\left|x_{error}\right|$', 'interpreter', 'latex');
ylim([10e-12 10e0]);
yticks([10e-12 10e-10 10e-8 10e-6 10e-4 10e-2 10e0]);
yticklabels({"$10^{-12}$", "$10^{-10}$", "$10^{-8}$", "$10^{-6}$", "$10^{-4}$", "$10^{-2}$", "$10^0$"});
pbaspect([1 1 1]);
saveas(g2,'err_nm.pdf');

%plot convergence order
g3 = figure(3); 
plot([3:length(o_n)+2], o_n, 'b-o', 'LineWidth', 1.5); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$\alpha$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g3,'order_nm.pdf');

%plot difference in logarithmic error
g4 = figure(4);
loglog(abs(x_errn(2:end-1) - x_errn(1:end-2)), abs(x_errn(3:end) - x_errn(2:end-1)), 'b-o', 'LineWidth', 1.5); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
xlabel('$log\left|x_{n} - x_e\right| - log\left|x_{n-1} - x_e\right|$', 'interpreter', 'latex');
ylabel('$log\left|x_{n+1} - x_e\right| - log\left|x_{n} - x_e\right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g4,'de_nm.pdf');
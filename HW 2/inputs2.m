clear all; clc;
%input arguments
f = @(x) exp(x) - x.^2;
a = -1; %bisection, false position, chord
b = 0.4; %bisection, false position, chord
x_0 = -0.4; %newton, secant
x_00 = b; %secant
tlr = 1e-10;
n_max = 1000;

%bisection
[x_, fx_, n_itr, err_abs] = myfzero(f, a, b, x_0, x_00, tlr, n_max, 'b');
[x_, fx_, n_itr, err_abs];
x_e = fzero(f, (a+b)./2) %bisection, false position, chord
x_errb = abs(x_e - x_);
%x_b = x_err;

%newton
[x_, fx_, n_itr, err_abs] = myfzero(f, a, b, x_0, x_00, tlr, n_max, 'n');
[x_, fx_, n_itr, err_abs];
x_e = fzero(f, x_0) %newton, secant
x_errn = abs(x_e - x_);
%x_n = x_err;

%chord
[x_, fx_, n_itr, err_abs] = myfzero(f, a, b, x_0, x_00, tlr, n_max, 'c');
[x_, fx_, n_itr, err_abs];
x_e = fzero(f, (a+b)./2) %bisection, false position, chord
x_errc = abs(x_e - x_);
%x_c = x_err;

%secant
[x_, fx_, n_itr, err_abs] = myfzero(f, a, b, x_0, x_00, tlr, n_max, 's');
[x_, fx_, n_itr, err_abs];
x_e = fzero(f, x_0) %newton, secant
x_errs = abs(x_e - x_);
%x_s = x_err;

%false position
[x_, fx_, n_itr, err_abs] = myfzero(f, a, b, x_0, x_00, tlr, n_max, 'f');
[x_, fx_, n_itr, err_abs];
x_e = fzero(f, (a+b)./2) %bisection, false position, chord
x_errf = abs(x_e - x_);
%x_f = x_err;

g11 = figure(11);
semilogy([1:length(x_errb)], x_errb, 'r--+', 'LineWidth', 1.5, 'DisplayName','Bisection'); hold on;
semilogy([1:length(x_errn)], x_errn, 'b-o', 'LineWidth', 1.5, 'DisplayName','Newton'); hold on;
semilogy([1:length(x_errc)], x_errc, 'k-^', 'LineWidth', 1.5, 'DisplayName','Chord'); hold on;
semilogy([1:length(x_errs)], x_errs, 'm-*', 'LineWidth', 1.5, 'DisplayName','Secant'); hold on;
semilogy([1:length(x_errf)], x_errf, 'g-x', 'LineWidth', 1.5, 'DisplayName','False position'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$\left| e_n \right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g11,'e_n.pdf');

o_b = (log(x_errb(3:end)) - log(x_errb(2:end-1)))./(log(x_errb(2:end-1)) - log(x_errb(1:end-2)));
o_n =(log(x_errn(3:end))-log(x_errn(2:end-1)))./(log(x_errn(2:end-1)) - log(x_errn(1:end-2)));
o_c =(log(x_errc(3:end)) - log(x_errc(2:end-1)))./(log(x_errc(2:end-1)) - log(x_errc(1:end-2)));
o_s =(log(x_errs(3:end)) - log(x_errs(2:end-1)))./(log(x_errs(2:end-1)) - log(x_errs(1:end-2)));
o_f =(log(x_errf(3:end)) - log(x_errf(2:end-1)))./(log(x_errf(2:end-1)) - log(x_errf(1:end-2)));

g12 = figure(12); plot([1:length(o_b)], o_b, 'r--+', 'LineWidth', 1.5, 'DisplayName','Bisection'); hold on;
plot([1:length(o_n)], o_n, 'b-o', 'LineWidth', 1.5, 'DisplayName','Newton'); hold on;
plot([1:length(o_c)], o_c, 'k-^', 'LineWidth', 1.5, 'DisplayName','Chord'); hold on;
plot([2:length(o_s)+1], o_s, 'm-*', 'LineWidth', 1.5, 'DisplayName','Secant'); hold on;
plot([1:length(o_f)], o_f, 'g-x', 'LineWidth', 1.5, 'DisplayName','False position'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'south', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$\alpha$', 'interpreter', 'latex');
ylim([-5 5]);
yticks([-5 -3 -1 1 3 5]);
pbaspect([1 1 1]);
saveas(g12,'order.pdf');

g13 = figure(13);
loglog(abs(x_errb(2:end-1) - x_errb(1:end-2)), abs(x_errb(3:end) - x_errb(2:end-1)), 'r--+', 'LineWidth', 1.5, 'DisplayName','Bisection'); hold on;
loglog(abs(x_errn(2:end-1) - x_errn(1:end-2)), abs(x_errn(3:end) - x_errn(2:end-1)), 'b-o', 'LineWidth', 1.5, 'DisplayName','Newton'); hold on;
loglog(abs(x_errc(2:end-1) - x_errc(1:end-2)), abs(x_errc(3:end) - x_errc(2:end-1)), 'k-^', 'LineWidth', 1.5, 'DisplayName','Chord'); hold on;
loglog(abs(x_errs(3:end-1) - x_errs(2:end-2)), abs(x_errs(4:end) - x_errs(3:end-1)), 'm-*', 'LineWidth', 1.5, 'DisplayName','Secant'); hold on;
loglog(abs(x_errf(2:end-1) - x_errf(1:end-2)), abs(x_errf(3:end) - x_errf(2:end-1)), 'g-x', 'LineWidth', 1.5, 'DisplayName','False position'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
%xtick = get(gca, 'xTick');
%xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northwest', 'interpreter', 'latex');
xlabel('$log\left|x_{n} - x_e\right| - log\left|x_{n-1} - x_e\right|$', 'interpreter', 'latex');
ylabel('$log\left|x_{n+1} - x_e\right| - log\left|x_{n} - x_e\right|$', 'interpreter', 'latex');
xlim([10e-13 10e0]);
ylim([10e-13 10e0]);
xticks([10e-12 10e-9 10e-6 10e-3 10e0]);
xticklabels({"$10^{-12}$", "$10^{-9}$", "$10^{-6}$", "$10^{-3}$", "$10^0$"});
yticks([10e-12 10e-9 10e-6 10e-3 10e0]);
yticklabels({"$10^{-12}$", "$10^{-9}$", "$10^{-6}$", "$10^{-3}$", "$10^0$"});
pbaspect([1 1 1]);
saveas(g13,'de_n.pdf');

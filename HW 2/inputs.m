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
x_err = abs(x_e - x_);
x_b = x_err;
g1 = figure(1); plot(n_itr, x_, 'r--+', 'LineWidth', 1.5, 'DisplayName','$x_n$'); hold on;
plot(n_itr, fx_, 'b-o', 'LineWidth', 1.5, 'DisplayName','$f(x_n)$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$x_n$, $f(x_n)$', 'interpreter', 'latex');
%ylim ([0 0.5]);
pbaspect([1 1 1]);
saveas(g1,'f_b.pdf');

g2 = figure(2);
semilogy(n_itr, err_abs, 'r--+', 'LineWidth', 1.5, 'DisplayName','$\left|x_n - x_{n-1}\right|$'); hold on;
semilogy(n_itr, x_err, 'b-o', 'LineWidth', 1.5, 'DisplayName','$\left|x_e - x_n\right|$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$\left|x_{error}\right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g2,'err_b.pdf');

%newton
[x_, fx_, n_itr, err_abs] = myfzero(f, a, b, x_0, x_00, tlr, n_max, 'n');
[x_, fx_, n_itr, err_abs];
x_e = fzero(f, x_0) %newton, secant
x_err = abs(x_e - x_);
x_n = x_err;
g3 = figure(3); plot(n_itr, x_, 'r--+', 'LineWidth', 1.5, 'DisplayName','$x_n$'); hold on;
plot(n_itr, fx_, 'b-o', 'LineWidth', 1.5, 'DisplayName','$f(x_n)$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$x_n$, $f(x_n)$', 'interpreter', 'latex');
%ylim ([0 0.5]);
pbaspect([1 1 1]);
saveas(g3,'f_n.pdf');

g4 = figure(4);
semilogy(n_itr, err_abs, 'r--+', 'LineWidth', 1.5, 'DisplayName','$\left|x_n - x_{n-1}\right|$'); hold on;
semilogy(n_itr, x_err, 'b-o', 'LineWidth', 1.5, 'DisplayName','$\left|x_e - x_n\right|$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$\left|x_{error}\right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g4,'err_n.pdf');

%chord
[x_, fx_, n_itr, err_abs] = myfzero(f, a, b, x_0, x_00, tlr, n_max, 'c');
[x_, fx_, n_itr, err_abs];
x_e = fzero(f, (a+b)./2) %bisection, false position, chord
x_err = abs(x_e - x_);
x_c = x_err;
g5 = figure(5); plot(n_itr, x_, 'r--+', 'LineWidth', 1.5, 'DisplayName','$x_n$'); hold on;
plot(n_itr, fx_, 'b-o', 'LineWidth', 1.5, 'DisplayName','$f(x_n)$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$x_n$, $f(x_n)$', 'interpreter', 'latex');
%ylim ([0 0.5]);
pbaspect([1 1 1]);
saveas(g5,'f_c.pdf');

g6 = figure(6);
semilogy(n_itr, err_abs, 'r--+', 'LineWidth', 1.5, 'DisplayName','$\left|x_n - x_{n-1}\right|$'); hold on;
semilogy(n_itr, x_err, 'b-o', 'LineWidth', 1.5, 'DisplayName','$\left|x_e - x_n\right|$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$\left|x_{error}\right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g6,'err_c.pdf');

%secant
[x_, fx_, n_itr, err_abs] = myfzero(f, a, b, x_0, x_00, tlr, n_max, 's');
[x_, fx_, n_itr, err_abs];
x_e = fzero(f, x_0) %newton, secant
x_err = abs(x_e - x_);
x_s = x_err;
g7 = figure(7); plot(n_itr, x_, 'r--+', 'LineWidth', 1.5, 'DisplayName','$x_n$'); hold on;
plot(n_itr, fx_, 'b-o', 'LineWidth', 1.5, 'DisplayName','$f(x_n)$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$x_n$, $f(x_n)$', 'interpreter', 'latex');
%ylim ([0 0.5]);
pbaspect([1 1 1]);
saveas(g7,'f_s.pdf');

g8 = figure(8);
semilogy(n_itr+1, err_abs, 'r--+', 'LineWidth', 1.5, 'DisplayName','$\left|x_n - x_{n-1}\right|$'); hold on;
semilogy(n_itr+1, x_err, 'b-o', 'LineWidth', 1.5, 'DisplayName','$\left|x_e - x_n\right|$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$\left|x_{error}\right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g8,'err_s.pdf');

%false position
[x_, fx_, n_itr, err_abs] = myfzero(f, a, b, x_0, x_00, tlr, n_max, 'f');
[x_, fx_, n_itr, err_abs];
x_e = fzero(f, (a+b)./2) %bisection, false position, chord
x_err = abs(x_e - x_);
x_f = x_err;
g9 = figure(9); plot(n_itr, x_, 'r--+', 'LineWidth', 1.5, 'DisplayName','$x_n$'); hold on;
plot(n_itr, fx_, 'b-o', 'LineWidth', 1.5, 'DisplayName','$f(x_n)$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$x_n$, $f(x_n)$', 'interpreter', 'latex');
%ylim ([0 0.5]);
pbaspect([1 1 1]);
saveas(g9,'f_f.pdf');

g10 = figure(10);
semilogy(n_itr, err_abs, 'r--+', 'LineWidth', 1.5, 'DisplayName','$\left|x_n - x_{n-1}\right|$'); hold on;
semilogy(n_itr, x_err, 'b-o', 'LineWidth', 1.5, 'DisplayName','$\left|x_e - x_n\right|$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit n', 'interpreter', 'latex');
ylabel('$\left|x_{error}\right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g10,'err_f.pdf');
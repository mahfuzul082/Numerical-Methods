clear all; clc;

syms x; syms k;
f = x; %function
a = -1; %lower bound
b = 1; %upper bound
l = (b-a)/2; %half-interval
n = 10000; %no. of coefficients

int_ = matlabFunction(1/l*int(f*sin(k*pi*x/l), x, a, b)); %coefficient $b_k$
b_k = [];
b_k_abs = [];
for k = 1:1:n
    b_ = int_(k);
    b_k = [b_k; b_];
    b_k_abs = [b_k_abs; abs(b_)];
end

fig1 = figure(1);
semilogy([1:length(b_k_abs)], b_k_abs, 'k', 'LineWidth', 1.5); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
xlabel('$k$', 'interpreter', 'latex');
ylabel('$\left|b_k\right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig1,'b-coeff.pdf');

fig2 = figure(2);
loglog([1:length(b_k_abs)], b_k_abs, 'k', 'LineWidth', 1.5); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
xlabel('$k$', 'interpreter', 'latex');
ylabel('$\left|b_k\right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig2,'b-coeff2.pdf');

ff = mod(x + 1, 2) - 1; %extension
s_k_arr = [];
k_ = 2.^(1:floor(log2(300))); 

for k = k_
    s_k = 0;
    for j = 1:1:k
        ss_j = b_k(j)*sin(j*pi*x/l);
        s_k = s_k + ss_j;
    end
    s_k_arr = [s_k_arr; s_k];
end
fig3 = figure(3);
fplot(f, [-1, 1], 'k', 'LineWidth', 1.5, 'DisplayName', '$f(x)$'); hold on;
legend_prop={};
for i = 1:length(s_k_arr)
    fplot(s_k_arr(i), [-1, 1], 'LineWidth', 1.5, 'DisplayName', ['$S_{' num2str(k_(i)) '}(x)$']); hold on;
    legend_prop{end+1} = ['$S_{' num2str(k_(i)) '}(x)$'];
end
hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('NumColumns', 3, 'Location', 'northwest', 'interpreter', 'latex');
xlabel('$x$', 'interpreter', 'latex');
ylabel('$y$', 'interpreter', 'latex');
pbaspect([1 0.8 1]);
saveas(fig3,'trunc1.pdf');

fig4 = figure(4);
fplot(ff, [-5, 5], 'k', 'LineWidth', 1.5, 'DisplayName', '$f(x)$'); hold on;
legend_prop={};
for i = 1:length(s_k_arr)
    fplot(s_k_arr(i), [-5, 5], 'LineWidth', 1.5, 'DisplayName', ['$S_{' num2str(k_(i)) '}(x)$']); hold on;
    legend_prop{end+1} = ['$S_{' num2str(k_(i)) '}(x)$'];
end
hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('NumColumns', 4, 'Location', 'north', 'interpreter', 'latex');
xlabel('$x$', 'interpreter', 'latex');
ylabel('$y$', 'interpreter', 'latex');
ylim([-2 2]);
pbaspect([1 0.8 1]);
saveas(fig4,'trunc2.pdf');

x_ = linspace(a, b, 700);
f_ = matlabFunction(f);
fig5 = figure(5);
legend_prop={};
for i = 1:length(s_k_arr)
    s_k_ = matlabFunction(s_k_arr(i));
    err = abs(f_(x_)-s_k_(x_)); %pointwise error
    semilogy(x_, err, 'LineWidth', 1.5, 'DisplayName', ['$\left|f(x) - S_{' num2str(k_(i)) '}(x)\right|$']); hold on;
    legend_prop{end+1} = ['$\left|f(x) - S_{' num2str(k_(i)) '}(x)\right|$'];
end
hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('NumColumns', 2, 'Location', 'south', 'interpreter', 'latex');
xlabel('$x$', 'interpreter', 'latex');
ylabel('$\left|f(x) - S_n(x)\right|$', 'interpreter', 'latex');
ylim([1e-7 1]);
pbaspect([1 0.8 1]);
saveas(fig5,'trunc_err.pdf');
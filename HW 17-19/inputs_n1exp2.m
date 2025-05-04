clear all; clc;
format longG;

%%inputs
x_ = [4.0 4.2 4.5 4.7 5.1 5.5 5.9 6.3 6.8 7.1];
x_ = log(x_);
y_ = [102.56 113.18 130.11 142.05 167.53 195.14 224.87 256.73 299.50 326.72];
y_ = log(y_);
degree = '1';

%%outputs
[fx_, lse] = curve_fit(x_, y_, degree);
syms x;
fx = vpa(expand(exp(vpa(expand(subs(fx_, x, log(x)))))));
lse = sum((exp(y_) - subs(fx,exp(x_))).^2);
fprintf("Polynomial fit (degree %s): ", degree); disp(fx);
fprintf("Least Squares Error (LSE): %g\n", lse);
fig1 = figure(1);
plot(exp(x_), exp(y_),'ko', 'LineWidth', 1.5, 'DisplayName', '$(x_i, y_i)$'); hold on;
fplot(fx, 'b', 'LineWidth', 1.5, 'DisplayName', '$f(x)$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'southeast', 'interpreter', 'latex');
xlabel('$x$', 'interpreter', 'latex');
ylabel('$y$', 'interpreter', 'latex');
xlim([3.5 7.5]);
pbaspect([1 1 1]);
saveas(fig1,'n1_exp2.pdf');
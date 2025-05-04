clear all;
clc;

format longG

%output arguments
x_= []; fx_= []; n_itr = []; err_abs = [];

%input arguments
f = input("Input function: "); %input function
x_0 = -0.5; %initial guess
tlr = 1.e-30; %tolerance
n_max = 100; %max. no. of iterations

%fixed point iteration
for i=1:n_max
    x_ = [x_;x_0]; %update the fixed point array
    x_1 = f(x_0); %formula for fixed point iterate
    fx_ = [fx_; x_1]; %update the array for function of fixed point
    n_itr = [n_itr; i]; %update the array for no. of iterations
    err_abs = [err_abs; abs(x_1 - x_0)]; %update the array for absolute error
    fprintf("After iteration no. %d, x_%d = %0.4f \n", i, i, x_1);
    if abs(x_1 - x_0) < tlr %alternatively, g(x_1) == x_1
        fprintf("Convergence reached at %dth iteration\n", i);
        break;
    else
        fprintf("Convergence not reached\n");
        end
    x_0 = x_1; %update the fixed point
end

[x_,fx_,n_itr,err_abs] %print the output arguments
%plot the output arguments
g1 = figure(1); plot(n_itr, x_, 'r--+', 'LineWidth', 1.5, 'DisplayName','$x_i$'); hold on;
plot(n_itr, fx_, 'b-o', 'LineWidth', 1.5, 'DisplayName','$f(x_i)$'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit i');
ylabel('$x_i$, $f(x_i)$');
pbaspect([1 1 1]);
saveas(g1,'g1.pdf');

g2 = figure(2);
semilogy(n_itr, err_abs, 'b-o', 'LineWidth', 1.5); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
tick = get(gca, 'xTick');
xticks(unique(round(tick)));
%legend('boxoff');
%legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit{No. of iterations}, \textit i');
ylabel('$\left|x_i - x_{i-1}\right|$');
pbaspect([1 1 1]);
saveas(g2,'g2.pdf');
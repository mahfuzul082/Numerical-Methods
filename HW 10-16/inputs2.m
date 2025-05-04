clear all; clc;
format longG

f = @(x) exp(x); %function
a = 0; %lower limit
b = 1; %upper limit
n = 22; %no. of subintervals

%int_ex = integral(f, a, b);
int_ex = f(1) - f(0) %exact integral

method = 't'; %'t' for trapezoidal
int_arrt = [];
h_arrt = [];
n_arrt = [];

for i = 1:1:n
    n_arrt = [n_arrt; i];
    h = (b-a)./i;
    h_arrt = [h_arrt; h];
    int = num_int(f, a, b, i, method);
    int_arrt = [int_arrt;int];
    if abs(int - int_ex) < 5e-4
        break;
    end
end
abs_errt = abs(int_ex - int_arrt);

method = 's'; %'s' for simpson's
int_arrs = [];
h_arrs = [];
n_arrs = [];

for i = 2:2:n
    n_arrs = [n_arrs; i];
    h = (b-a)./i;
    h_arrs = [h_arrs; h];
    int = num_int(f, a, b, i, method);
    int_arrs = [int_arrs;int];
    if abs(int - int_ex) < 5e-4
        break;
    end
end
abs_errs = abs(int_ex - int_arrs);

fig1 = figure(1);
semilogy(n_arrt, abs_errt, 'r--x', 'LineWidth', 1.5, 'DisplayName', 'Trapezoidal'); hold on;
semilogy(n_arrs, abs_errs, 'b-+', 'LineWidth', 1.5, 'DisplayName', 'Simpson''s'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'northeast', 'interpreter', 'latex');
xlabel('\textit m', 'interpreter', 'latex');
ylabel('$E_{abs}$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig1,'err_ver.pdf');
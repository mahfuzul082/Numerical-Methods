clear all; clc;
format longG

f = @(x) abs(x).*exp(x); %function
a = 0; %lower limit
b = 1; %upper limit
n = 1000; %no. of subintervals

%int_ex = integral(f, a, b);
int_ex = 1; %exact integral

%% midpoint
method = 'm'; %'m' for midpoint
int_arrm = [];
h_arrm = [];

for i = 1:1:n
    h = (b-a)./i;
    h_arrm = [h_arrm; h];
    int = num_int(f, a, b, i, method);
    int_arrm = [int_arrm;int];
end
abs_errm = abs(int_ex - int_arrm);

fig1 = figure(1);
loglog(h_arrm, abs_errm, 'k-o', 'LineWidth', 1.5); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
xlabel('\textit h', 'interpreter', 'latex');
ylabel('$E_{abs}$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig1,'mid_err.pdf');

fig2 = figure(2);
plot(h_arrm, int_arrm, 'k-o', 'LineWidth', 1.5); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
xlabel('\textit h', 'interpreter', 'latex');
ylabel('\textit I', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig2,'mid.pdf');

%% trapezoidal
method = 't'; %'t' for trapezoidal
int_arrt = [];
h_arrt = [];

for i = 1:1:n
    h = (b-a)./i;
    h_arrt = [h_arrt; h];
    int = num_int(f, a, b, i, method);
    int_arrt = [int_arrt;int];
end
abs_errt = abs(int_ex - int_arrt);

fig3 = figure(3);
loglog(h_arrt, abs_errt, 'k-o', 'LineWidth', 1.5); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
xlabel('\textit h', 'interpreter', 'latex');
ylabel('$E_{abs}$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig3,'trap_err.pdf');

fig4 = figure(4);
plot(h_arrt, int_arrt, 'k-o', 'LineWidth', 1.5); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
xlabel('\textit h', 'interpreter', 'latex');
ylabel('\textit I', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig4,'trap.pdf');

%% Simpson's
method = 's'; %'s' for simpson's
int_arrs = [];
h_arrs = [];

for i = 2:2:n
    h = (b-a)./i;
    h_arrs = [h_arrs; h];
    int = num_int(f, a, b, i, method);
    int_arrs = [int_arrs;int];
end
abs_errs = abs(int_ex - int_arrs);

fig5 = figure(5);
loglog(h_arrs, abs_errs, 'k-o', 'LineWidth', 1.5); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
xlabel('\textit h', 'interpreter', 'latex');
ylabel('$E_{abs}$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig5,'simp_err.pdf');

fig6 = figure(6);
plot(h_arrs, int_arrs, 'k-o', 'LineWidth', 1.5); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
xlabel('\textit h', 'interpreter', 'latex');
ylabel('\textit I', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig6,'simp.pdf');

%% comparison
fig7 = figure(7);
loglog(h_arrm, abs_errm, 'k-o', 'LineWidth', 1.5, 'DisplayName', 'Midpoint'); hold on;
loglog(h_arrt, abs_errt, 'r--x', 'LineWidth', 1.5, 'DisplayName', 'Trapezoidal'); hold on;
loglog(h_arrs, abs_errs, 'b-+', 'LineWidth', 1.5, 'DisplayName', 'Simpson''s'); hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'southeast', 'interpreter', 'latex');
xlabel('\textit h', 'interpreter', 'latex');
ylabel('$E_{abs}$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig7,'com.pdf');
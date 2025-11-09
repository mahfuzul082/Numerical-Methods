clear all; clc;

l = 2*pi;
n = 150;
dx = l/n;
x = linspace(0, l-dx, n);
t_f = 2*pi;
cfl = 0.5;
dt = cfl*dx;
nt = floor(t_f/dt);
t = linspace(0, t_f, nt);

u_0 = sin(x);

%central differencing+forward euler
u_fecd = u_0;
T_fecd = [];
U_fecd = [];
for i = 1:nt
    T_fecd = [T_fecd;i];
    u_fecd(2:end-1) = u_0(2:end-1)+dt/(2*dx)*(u_0(3:end)-u_0(1:end-2));
    u_fecd(1) = u_0(1)+dt/(2*dx)*(u_0(2)-u_0(end));
    u_fecd(end) = u_0(end)+dt/(2*dx)*(u_0(1)-u_0(end-1));
    U_fecd = [U_fecd;u_fecd];
    u_0 = u_fecd;
end

g1 = figure(1);
plot([x,2*pi], [U_fecd(end,:), u_fecd(1)], 'ro', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName','FECD'); hold on;
plot([x,2*pi], [sin(x+t_f), sin(t_f)], 'k-', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName','Exact'); hold off;
set(gca,'XTick',[0,pi/2,pi,3*pi/2,2*pi],'XTickLabel', {'$0$', '$\frac{\pi}{2}$', '$\pi$', '$\frac{3\pi}{2}$', '$2\pi$'},'TicklabelInterpreter','latex','FontSize', 13);
xlabel("$x$", 'interpreter', 'latex');
ylabel("$u$", 'interpreter', 'latex');
xlim([0 2*pi]);
ylim([-1.2 1.2]);
legend("boxoff");
legend('Location', 'northeast', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g1,'fecd.pdf');

%forward differencing+forward euler
u_fefd = u_0;
T_fefd = [];
U_fefd = [];
for i = 1:nt
    T_fefd = [T_fefd;i];
    u_fefd(2:end-1) = u_0(2:end-1)+dt/dx*(u_0(3:end)-u_0(2:end-1));
    u_fefd(1) = u_0(1)+dt/dx*(u_0(2)-u_0(1));
    u_fefd(end) = u_0(end)+dt/dx*(u_0(1)-u_0(end));
    U_fefd = [U_fefd;u_fefd];
    u_0 = u_fefd;
end

g2 = figure(2);
plot([x,2*pi], [U_fefd(end,:), u_fefd(1)], 'ro', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName','FEFD'); hold on;
plot([x,2*pi], [sin(x+t_f), sin(t_f)], 'k-', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName','Exact'); hold off;
set(gca,'XTick',[0,pi/2,pi,3*pi/2,2*pi],'XTickLabel', {'$0$', '$\frac{\pi}{2}$', '$\pi$', '$\frac{3\pi}{2}$', '$2\pi$'},'TicklabelInterpreter','latex','FontSize', 13);
xlabel("$x$", 'interpreter', 'latex');
ylabel("$u$", 'interpreter', 'latex');
xlim([0 2*pi]);
ylim([-1.2 1.2]);
legend("boxoff");
legend('Location', 'northeast', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g2,'fefd.pdf');

%Leap frog
u_00 = u_0;

u_lf = u_0;
T_lf = [];
U_lf = [];
for i = 1:nt
    T_lf = [T_lf;i];
    if i == 1
        u_00(2:end-1) = u_0(2:end-1)+dt/(2*dx)*(u_0(3:end)-u_0(1:end-2));
        u_00(1) = u_0(1)+dt/(2*dx)*(u_0(2)-u_0(end));
        u_00(end) = u_0(end)+dt/(2*dx)*(u_0(1)-u_0(end-1));
    else
        u_lf(2:end-1) = u_0(2:end-1)+dt/dx*(u_00(3:end)-u_00(1:end-2));
        u_lf(1) = u_0(1)+dt/dx*(u_00(2)-u_00(end));
        u_lf(end) = u_0(end)+dt/dx*(u_00(1)-u_00(end-1));
        U_lf = [U_lf;u_lf];
        u_0 = u_00;
        u_00 = u_lf;
    end
end

g3 = figure(3);
plot([x,2*pi], [U_lf(end,:), u_lf(1)], 'ro', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName','Leap Frog'); hold on;
plot([x,2*pi], [sin(x+t_f), sin(t_f)], 'k-', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName','Exact'); hold off;
set(gca,'XTick',[0,pi/2,pi,3*pi/2,2*pi],'XTickLabel', {'$0$', '$\frac{\pi}{2}$', '$\pi$', '$\frac{3\pi}{2}$', '$2\pi$'},'TicklabelInterpreter','latex','FontSize', 13);
xlabel("$x$", 'interpreter', 'latex');
ylabel("$u$", 'interpreter', 'latex');
xlim([0 2*pi]);
ylim([-1.2 1.2]);
legend("boxoff");
legend('Location', 'northeast', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g3,'leap_frog.pdf');

%Lax Wendroff
u_lw = u_0;
T_lw = [];
U_lw = [];
for i = 1:nt
    T_lw = [T_lw;i];
    u_lw(2:end-1) = u_0(2:end-1)+dt/(2*dx)*(u_0(3:end)-u_0(1:end-2))+(dt)^2/(2*(dx)^2)*(u_0(3:end)-2*u_0(2:end-1)+u_0(1:end-2));
    u_lw(1) = u_0(1)+dt/(2*dx)*(u_0(2)-u_0(end))+(dt)^2/(2*(dx)^2)*(u_0(2)-2*u_0(1)+u_0(end));
    u_lw(end) = u_0(end)+dt/(2*dx)*(u_0(1)-u_0(end-1))+(dt)^2/(2*(dx)^2)*(u_0(1)-2*u_0(end)+u_0(end-1));
    U_lw = [U_lw;u_lw];
    u_0 = u_lw;
end

g4 = figure(4);
plot([x,2*pi], [U_lw(end,:), u_lw(1)], 'ro', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName','Lax Wendroff'); hold on; 
plot([x,2*pi], [sin(x+t_f), sin(t_f)], 'k-', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName','Exact'); hold off;
set(gca,'XTick',[0,pi/2,pi,3*pi/2,2*pi],'XTickLabel', {'$0$', '$\frac{\pi}{2}$', '$\pi$', '$\frac{3\pi}{2}$', '$2\pi$'},'TicklabelInterpreter','latex','FontSize', 13);
xlabel("$x$", 'interpreter', 'latex');
ylabel("$u$", 'interpreter', 'latex');
xlim([0 2*pi]);
ylim([-1.2 1.2]);
legend("boxoff");
legend('Location', 'northeast', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g4,'lax_wendroff.pdf');

%implicit
u_imp = u_0;
T_imp = [];
U_imp = [];

o = ones(n, 1);
mu = dt/dx;
A = spdiags([-mu*o, (1+mu)*o], [1, 0], n, n);
A(end, 1) = -mu;

for i = 1:nt
    T_imp = [T_imp; i];
    u_imp = A \ u_0'; 
    u_imp = u_imp';       
    U_imp = [U_imp; u_imp];
    u_0 = u_imp;
end

g5 = figure(5);
plot([x,2*pi], [U_imp(end,:), u_imp(1)], 'ro', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName','Implicit'); hold on;
plot([x,2*pi], [sin(x+t_f), sin(t_f)], 'k-', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName','Exact'); hold off;
set(gca,'XTick',[0,pi/2,pi,3*pi/2,2*pi],'XTickLabel', {'$0$', '$\frac{\pi}{2}$', '$\pi$', '$\frac{3\pi}{2}$', '$2\pi$'},'TicklabelInterpreter','latex','FontSize', 13);
xlabel("$x$", 'interpreter', 'latex');
ylabel("$u$", 'interpreter', 'latex');
xlim([0 2*pi]);
ylim([-1.2 1.2]);
legend("boxoff");
legend('Location', 'northeast', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g5,'implicit.pdf');

%Crank-Nicholson
u_0 = sin(x); 
u_cn = u_0;
T_cn = [];
U_cn = [];

o = ones(n, 1);
mu = dt/dx;
A = spdiags([mu/4*o, o, -mu/4*o], -1:1, n, n);
A(end, 1) = -mu/4;
A(1, end) = mu/4;
B = spdiags([-mu/4*o, o, mu/4*o], -1:1, n, n);
B(end, 1) = mu/4;
B(1, end) = -mu/4;

for i = 1:nt
    T_cn = [T_cn; i];
    b = B*u_0';
    u_cn = (A \ b)';
    %u_cn = u_cn';
    U_cn = [U_cn; u_cn];
    u_0 = u_cn;
end

g6 = figure(6);
plot([x,2*pi], [U_cn(end,:), u_cn(1)], 'ro', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName','Crank-Nicholson'); hold on;
plot([x,2*pi], [sin(x+t_f), sin(t_f)], 'k-', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName','Exact'); hold off;
set(gca,'XTick',[0,pi/2,pi,3*pi/2,2*pi],'XTickLabel', {'$0$', '$\frac{\pi}{2}$', '$\pi$', '$\frac{3\pi}{2}$', '$2\pi$'},'TicklabelInterpreter','latex','FontSize', 13);
xlabel("$x$", 'interpreter', 'latex');
ylabel("$u$", 'interpreter', 'latex');
xlim([0 2*pi]);
ylim([-1.2 1.2]);
legend("boxoff");
legend('Location', 'northeast', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(g6,'crank_nicholson.pdf');
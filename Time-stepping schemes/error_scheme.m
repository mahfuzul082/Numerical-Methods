clear all; clc;

l = 2*pi;
n = 200;
dx = l/n;
x = linspace(0, l-dx, n);
t_f = 2*pi;
cfl = 0.1:0.1:0.9;
dt = cfl*dx;
%nt = floor(t_f/dt);
%t = linspace(0, t_f, nt);

u = sin(x+t_f);

%central differencing+forward euler
T_fecd = [];
U_fecd = [];
err_fecd = [];

for j=1:length(dt)
    nt = floor(t_f/dt(j));
    t = linspace(0, t_f, nt);

    u_0 = sin(x);
    u_fecd = u_0;

    for i = 1:nt
        T_fecd = [T_fecd;i];
        u_fecd(2:end-1) = u_0(2:end-1)+dt(j)/(2*dx)*(u_0(3:end)-u_0(1:end-2));
        u_fecd(1) = u_0(1)+dt(j)/(2*dx)*(u_0(2)-u_0(end));
        u_fecd(end) = u_0(end)+dt(j)/(2*dx)*(u_0(1)-u_0(end-1));
        U_fecd = [U_fecd;u_fecd];
        u_0 = u_fecd;
    end
    error = max(abs(u-U_fecd(end,:)));
    err_fecd = [err_fecd;error];
end
disp(err_fecd);

%forward differencing+forward euler
T_fefd = [];
U_fefd = [];
err_fefd = [];

for j=1:length(dt)
    nt = floor(t_f/dt(j));
    t = linspace(0, t_f, nt);

    u_0 = sin(x);
    u_fefd = u_0;

    for i = 1:nt
        T_fefd = [T_fefd;i];
        u_fefd(2:end-1) = u_0(2:end-1)+dt(j)/dx*(u_0(3:end)-u_0(2:end-1));
        u_fefd(1) = u_0(1)+dt(j)/dx*(u_0(2)-u_0(1));
        u_fefd(end) = u_0(end)+dt(j)/dx*(u_0(1)-u_0(end));
        U_fefd = [U_fefd;u_fefd];
        u_0 = u_fefd;
    end
    error = max(abs(u-U_fefd(end,:)));
    err_fefd = [err_fefd;error];
end
disp(err_fefd);

%Leap frog
T_lf = [];
U_lf = [];
err_lf = [];

for j=1:length(dt)
    nt = floor(t_f/dt(j));
    t = linspace(0, t_f, nt);

    u_0 = sin(x);
    u_00 = u_0;
    u_lf = u_0;

    for i = 1:nt
        T_lf = [T_lf;i];
        if i == 1
            u_00(2:end-1) = u_0(2:end-1)+dt(j)/(2*dx)*(u_0(3:end)-u_0(1:end-2));
            u_00(1) = u_0(1)+dt(j)/(2*dx)*(u_0(2)-u_0(end));
            u_00(end) = u_0(end)+dt(j)/(2*dx)*(u_0(1)-u_0(end-1));
        else
            u_lf(2:end-1) = u_0(2:end-1)+dt(j)/dx*(u_00(3:end)-u_00(1:end-2));
            u_lf(1) = u_0(1)+dt(j)/dx*(u_00(2)-u_00(end));
            u_lf(end) = u_0(end)+dt(j)/dx*(u_00(1)-u_00(end-1));
            U_lf = [U_lf;u_lf];
            u_0 = u_00;
            u_00 = u_lf;
        end
    end
    if nt == 1
        error = max(abs(u - u_00));
    else
        error = max(abs(u - U_lf(end,:)));
    end
    err_lf = [err_lf; error];
end
disp(err_lf);

%Lax Wendroff
T_lw = [];
U_lw = [];
err_lw = [];

for j=1:length(dt)
    nt = floor(t_f/dt(j));
    t = linspace(0, t_f, nt);

    u_0 = sin(x);
    u_lw = u_0;
    for i = 1:nt
        T_lw = [T_lw;i];
        u_lw(2:end-1) = u_0(2:end-1)+dt(j)/(2*dx)*(u_0(3:end)-u_0(1:end-2))+(dt(j))^2/(2*(dx)^2)*(u_0(3:end)-2*u_0(2:end-1)+u_0(1:end-2));
        u_lw(1) = u_0(1)+dt(j)/(2*dx)*(u_0(2)-u_0(end))+(dt(j))^2/(2*(dx)^2)*(u_0(2)-2*u_0(1)+u_0(end));
        u_lw(end) = u_0(end)+dt(j)/(2*dx)*(u_0(1)-u_0(end-1))+(dt(j))^2/(2*(dx)^2)*(u_0(1)-2*u_0(end)+u_0(end-1));
        U_lw = [U_lw;u_lw];
        u_0 = u_lw;
    end
    error = max(abs(u-U_lw(end,:)));
    err_lw = [err_lw;error];
end
disp(err_lw);

%implicit
T_imp = [];
U_imp = [];
err_imp = [];

for j=1:length(dt)
    o = ones(n, 1);
    mu = dt(j)/dx;
    A = spdiags([-mu*o, (1+mu)*o], [1, 0], n, n);
    A(end, 1) = -mu;
    nt = floor(t_f/dt(j));
    t = linspace(0, t_f, nt);

    u_0 = sin(x);
    u_imp = u_0;
    for i = 1:nt
        T_imp = [T_imp; i];
        u_imp = A \ u_0'; 
        u_imp = u_imp';       
        U_imp = [U_imp; u_imp];
        u_0 = u_imp;
    end
    error = max(abs(u-U_imp(end,:)));
    err_imp = [err_imp;error];
end
disp(err_imp);


%Crank-Nicholson
T_cn = [];
U_cn = [];
err_cn = [];

for j=1:length(dt)
    o = ones(n, 1);
    mu = dt(j)/dx;
    A = spdiags([mu/4*o, o, -mu/4*o], -1:1, n, n);
    A(end, 1) = -mu/4;
    A(1, end) = mu/4;
    B = spdiags([-mu/4*o, o, mu/4*o], -1:1, n, n);
    B(end, 1) = mu/4;
    B(1, end) = -mu/4;
    nt = floor(t_f/dt(j));
    t = linspace(0, t_f, nt);

    u_0 = sin(x);
    u_cn = u_0;
    for i = 1:nt
        T_cn = [T_cn; i];
        b = B*u_0';
        u_cn = (A \ b)';
        %u_cn = u_cn';
        U_cn = [U_cn; u_cn];
        u_0 = u_cn;
    end
    error = max(abs(u-U_cn(end,:)));
    err_cn = [err_cn;error];
end
disp(err_cn);

h = figure(1); 
semilogy(dt, err_fecd, '-o', 'LineWidth', 2, 'DisplayName', 'FECD'); hold on;
semilogy(dt, err_fefd, '-x', 'LineWidth', 2, 'DisplayName', 'FEFD'); hold on;
semilogy(dt, err_lf, '-<', 'LineWidth', 2, 'DisplayName', 'Leap Frog'); hold on;
semilogy(dt, err_lw, '->', 'LineWidth', 2, 'DisplayName', 'Lax Wendroff'); hold on;
semilogy(dt, err_imp, '-^', 'LineWidth', 2, 'DisplayName', 'Implicit'); hold on;
semilogy(dt, err_cn, '-*', 'LineWidth', 2, 'DisplayName', 'Crank Nicholson'); hold off;
set(gca, 'TicklabelInterpreter','latex','FontSize', 13);
%grid on;
legend('boxoff');
legend('Location', 'northwest', 'interpreter', 'latex');
xlabel('$\Delta t$','interpreter', 'latex');
ylabel('$|Error|$','interpreter', 'latex');
%xlim([0.1 0.001]);
pbaspect([1 1 1]);
saveas(h,'error.pdf');
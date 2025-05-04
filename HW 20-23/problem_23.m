clear all; clc;

syms x; syms k;
f = x; %function
a = -1; %lower bound
b = 1; %upper bound
l = (b-a)/2; %half-interval
n = 10000; %no.of coefficients

int_ = matlabFunction(1/l*int(f*sin(k*pi*x/l), x, a, b)); %coefficient $b_k$
b_k = [];
b_k_abs = [];
for k = 1:1:n
    b_ = int_(k);
    b_k = [b_k; b_];
    b_k_abs = [b_k_abs; abs(b_)];
end

%% Cesaro filter
syms k; syms n;
w = matlabFunction((1-k/n), "Vars", {k, n}); %filter
s_k_arr = [];
k_ = 2.^(1:floor(log2(300))); 
for k = k_
    s_k = 0;
    for j = 1:1:k
        ss_j = w(j, k)*b_k(j)*sin(j*pi*x/l); %filtered fourier term
        s_k = s_k + ss_j;
    end
    s_k_arr = [s_k_arr; s_k];
end

fig1 = figure(1);
fplot(f, [-1, 1], 'k', 'LineWidth', 1.5, 'DisplayName', '$f(x)$'); hold on;
legend_prop={};
for i = 1:length(s_k_arr)
    fplot(s_k_arr(i), [-1, 1], 'LineWidth', 1.5, 'DisplayName', ['$S_{' num2str(k_(i)) '}(x)$']); hold on;
    legend_prop{end+1} = ['$S_{' num2str(k_(i)) '}(x)$'];
end
hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('NumColumns', 2, 'Location', 'northwest', 'interpreter', 'latex');
xlabel('$x$', 'interpreter', 'latex');
ylabel('$y$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig1,'cesaro_f.pdf');

x_ = linspace(a, b, 1000);
f_ = matlabFunction(f);
fig2 = figure(2);
legend_prop={};
for i = 1:length(s_k_arr)
    s_k_ = matlabFunction(s_k_arr(i));
    err = abs(f_(x_)-s_k_(x_)); %error
    semilogy(x_, err, 'LineWidth', 1.5, 'DisplayName', ['$\left|f(x) - S_{' num2str(k_(i)) '}(x)\right|$']); hold on;
    legend_prop{end+1} = ['$\left|f(x) - S_{' num2str(k_(i)) '}(x)\right|$'];
end
hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('NumColumns', 2, 'Location', 'southwest', 'interpreter', 'latex');
xlabel('$x$', 'interpreter', 'latex');
ylabel('$\left|f(x) - S_n(x)\right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
ylim([1e-15 1]);
saveas(fig2,'cesaro_err.pdf');

%% Raised Cosine filter
syms k; syms n;
w = matlabFunction(1/2*(1+cos(pi*k/n)), "Vars", {k, n}); %filter
s_k_arr = [];
k_ = 2.^(1:floor(log2(300))); 
for k = k_
    s_k = 0;
    for j = 1:1:k
        ss_j = w(j, k)*b_k(j)*sin(j*pi*x/l); %filtered fourier term
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
legend('NumColumns', 2, 'Location', 'northwest', 'interpreter', 'latex');
xlabel('$x$', 'interpreter', 'latex');
ylabel('$y$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig3,'raisedcosine_f.pdf');

x_ = linspace(a, b, 1000);
f_ = matlabFunction(f);
fig4 = figure(4);
legend_prop={};
for i = 1:length(s_k_arr)
    s_k_ = matlabFunction(s_k_arr(i));
    err = abs(f_(x_)-s_k_(x_)); %error
    semilogy(x_, err, 'LineWidth', 1.5, 'DisplayName', ['$\left|f(x) - S_{' num2str(k_(i)) '}(x)\right|$']); hold on;
    legend_prop{end+1} = ['$\left|f(x) - S_{' num2str(k_(i)) '}(x)\right|$'];
end
hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('NumColumns', 2, 'Location', 'southwest', 'interpreter', 'latex');
xlabel('$x$', 'interpreter', 'latex');
ylabel('$\left|f(x) - S_n(x)\right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
ylim([1e-15 1]);
saveas(fig4,'raisedcosine_err.pdf');

%% Lanczos filter
syms k; syms n;
w = matlabFunction((sin(pi*k/n))/(pi*k/n), "Vars", {k, n}); %filter
s_k_arr = [];
k_ = 2.^(1:floor(log2(300))); 
for k = k_
    s_k = 0;
    for j = 1:1:k
        ss_j = w(j, k)*b_k(j)*sin(j*pi*x/l); %filtered fourier term
        s_k = s_k + ss_j;
    end
    s_k_arr = [s_k_arr; s_k];
end

fig5 = figure(5);
fplot(f, [-1, 1], 'k', 'LineWidth', 1.5, 'DisplayName', '$f(x)$'); hold on;
legend_prop={};
for i = 1:length(s_k_arr)
    fplot(s_k_arr(i), [-1, 1], 'LineWidth', 1.5, 'DisplayName', ['$S_{' num2str(k_(i)) '}(x)$']); hold on;
    legend_prop{end+1} = ['$S_{' num2str(k_(i)) '}(x)$'];
end
hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('NumColumns', 2, 'Location', 'northwest', 'interpreter', 'latex');
xlabel('$x$', 'interpreter', 'latex');
ylabel('$y$', 'interpreter', 'latex');
pbaspect([1 1 1]);
saveas(fig5,'lanczos_f.pdf');

x_ = linspace(a, b, 1000);
f_ = matlabFunction(f);
fig6 = figure(6);
legend_prop={};
for i = 1:length(s_k_arr)
    s_k_ = matlabFunction(s_k_arr(i));
    err = abs(f_(x_)-s_k_(x_)); %error
    semilogy(x_, err, 'LineWidth', 1.5, 'DisplayName', ['$\left|f(x) - S_{' num2str(k_(i)) '}(x)\right|$']); hold on;
    legend_prop{end+1} = ['$\left|f(x) - S_{' num2str(k_(i)) '}(x)\right|$'];
end
hold off;
set(gca,'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('NumColumns', 2, 'Location', 'southwest', 'interpreter', 'latex');
xlabel('$x$', 'interpreter', 'latex');
ylabel('$\left|f(x) - S_n(x)\right|$', 'interpreter', 'latex');
pbaspect([1 1 1]);
ylim([1e-15 1]);
saveas(fig6,'lanczos_err.pdf');

%% Exponential filter
syms k; syms n; syms eta_c; syms alp;
eta_c = 0.1; %threshold
k_ = 2.^(1:floor(log2(300))); 

for alp = 3.^(1:floor(log2(16)))
    s_k_arr = [];
    kk = [];
    for n = k_
        s_k = 0;
        for k = 1:1:n
            if abs(k/n) >= 0 && abs(k/n) < eta_c
                w = 1; %filter
                ss_k = w*b_k(k)*sin(k*pi*x/l); %filtered fourier term
                s_k = s_k + ss_k;
            else
                w = exp(-alp*((k/n - eta_c)/(1 - eta_c))^(n/4)); %filter
                ss_k = w*b_k(k)*sin(k*pi*x/l); %filtered fourier term
                s_k = s_k + ss_k;
            end
        end
        s_k_arr = [s_k_arr; s_k];
        kk = [kk; n];
    end
    fig = figure(alp+10);
    fplot(f, [-1, 1], 'k', 'LineWidth', 1.5, 'DisplayName', '$f(x)$'); hold on;
    legend_prop={};
    for i = 1:length(s_k_arr)
        fplot(s_k_arr(i), [-1, 1], 'LineWidth', 1.5, 'DisplayName', ['$S_{' num2str(kk(i)) '}(x)$']); hold on;
        legend_prop{end+1} = ['$S_{' num2str(kk(i)) '}(x)$'];
    end
    hold off;
    set(gca,'TicklabelInterpreter','latex','FontSize', 13);
    legend('boxoff');
    legend('NumColumns', 2, 'Location', 'northwest', 'interpreter', 'latex');
    xlabel('$x$', 'interpreter', 'latex');
    ylabel('$y$', 'interpreter', 'latex');
    pbaspect([1 1 1]);
    saveas(fig,['exp_f_alp' num2str(alp) '.pdf']);
    
    x_ = linspace(a, b, 1000);
    f_ = matlabFunction(f);
    fig = figure(alp+50);
    legend_prop={};
    for i = 1:length(s_k_arr)
        s_k_ = matlabFunction(s_k_arr(i));
        err = abs(f_(x_)-s_k_(x_)); %error
        semilogy(x_, err, 'LineWidth', 1.5, 'DisplayName', ['$\left|f(x) - S_{' num2str(kk(i)) '}(x)\right|$']); hold on;
        legend_prop{end+1} = ['$\left|f(x) - S_{' num2str(kk(i)) '}(x)\right|$'];
    end
    hold off;
    set(gca,'TicklabelInterpreter','latex','FontSize', 13);
    legend('boxoff');
    legend('NumColumns', 2, 'Location', 'south', 'interpreter', 'latex');
    xlabel('$x$', 'interpreter', 'latex');
    ylabel('$\left|f(x) - S_n(x)\right|$', 'interpreter', 'latex');
    ylim([1e-15 1]);
    pbaspect([1 1 1]);
    saveas(fig,['exp_err_alp' num2str(alp) '.pdf']);
end
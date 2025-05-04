clear all; clc;

syms x;
f = exp(x).*cos(2*x); %function
a = -pi; %lower bound
b = pi; %upper bound
m = 4; 
n = 3; %degree of polynomial
xx = [];
yy = [];
for j = 0:1:2*m-1
    x_ = a + j/m*b; %computing data points along x-axis
    xx = [xx; x_];
    yy = [yy; subs(f,x_)];
end
a_k = [];
for k = 0:1:n
    a_ = vpa(expand(sum(yy.*cos(k.*xx))/m)); %coefficient $a_k$
    a_k = [a_k; a_];
end
b_k = [];
for k = 1:1:n-1
    b_ = vpa(expand(sum(yy.*sin(k.*xx))/m)); %coefficient $b_k$
    b_k = [b_k; b_];
end
s_3 = a_k(1)/2 + a_k(2)*cos(x) + a_k(3)*cos(2*x) + a_k(4)*cos(3*x) + b_k(1)*sin(x) + b_k(2)*sin(2*x); %approximated trigonometric polynomial
fprintf("S_3: "); disp(s_3);
lse = sum((yy - subs(s_3,xx)).^2); %least squares error $E(S_3)$
fprintf("LSE: %g\n", lse);

fig1 = figure(1);
fplot(f, 'k', 'LineWidth', 1.5, 'DisplayName', '$f(x)$'); hold on;
fplot(s_3, 'b', 'LineWidth', 1.5, 'DisplayName', '$S_3(x)$'); hold off;
set(gca,'XTick', [-pi 0 pi], 'XTickLabel',{'$-\pi$','0','$\pi$'},'TicklabelInterpreter','latex','FontSize', 13);
legend('boxoff');
legend('Location', 'northwest', 'interpreter', 'latex');
xlabel('$x$', 'interpreter', 'latex');
ylabel('$y$', 'interpreter', 'latex');
xlim([-pi pi]);
%ylim([-1.5 1.5]);
pbaspect([1 1 1]);
saveas(fig1,'trig_poly_disc.pdf');
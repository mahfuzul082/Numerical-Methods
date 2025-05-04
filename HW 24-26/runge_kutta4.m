function [t, x] = runge_kutta4(f, t_i, h, t_f)

x = [];
x(1) = 0; %initial value
t = t_i:h:t_f; %time-steps

for i = 1:length(t)-1
    k1 = h*f(t(i), x(i)); %$K_1$
    k2 = h*f(t(i)+h/2, x(i)+k1/2); %$K_2$
    k3 = h*f(t(i)+h/2, x(i)+k2/2); %$K_3$
    k4 = h*f(t(i)+h, x(i)+k3); %$K_4$
    x(i+1) = x(i) + 1/6*(k1+2*k2+2*k3+k4); %fourth order runge-kutta formula
    fprintf("x(%g) = %g\n", i+1, x(i+1));
end
end
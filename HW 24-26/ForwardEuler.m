function [t, y] = ForwardEuler(f, t_i, h, t_f)

y = [];
y(1) = 2; %initial value
t = t_i:h:t_f; %time-steps

for i = 1:length(t)-1
    y(i+1) = y(i) + h*f(t(i), y(i)); %forward euler formula
    fprintf("y(%g) = %g\n", i+1, y(i+1));
end
end
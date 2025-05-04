function [t_o, y_o] = Taylor(f, t_i, h, t_f, order)

syms t y(t) yy;
y_o = [];
y_o(1) = 2; %initial value
t_o = t_i:h:t_f; %time-steps
y1_ = matlabFunction(subs(f, y(t), yy), 'Vars',[t, yy]);

switch order
    case '2'
        y2 = diff(f, t, 1);
        y2_ = matlabFunction(subs(subs(y2, diff(y(t), t), f), y(t), yy), 'Vars', [t, yy]); %1st derivative of $f$
        for i = 1:length(t_o)-1
            y_o(i+1) = y_o(i) + h*y1_(t_o(i), y_o(i)) + h^2/2*y2_(t_o(i), y_o(i)); %2nd order taylor's formula
            fprintf("y(%g) = %g\n", i+1, y_o(i+1));
        end
    case '4'
        y2 = diff(f, t, 1);
        y3 = diff(f, t, 2);
        y4 = diff(f, t, 3);
        y2_ = matlabFunction(subs(subs(y2, diff(y(t), t), f), y(t), yy), 'Vars',[t, yy]); %1st derivative of $f$
        y3_ = matlabFunction(subs(subs(subs(y3, diff(y(t), t, t), y2), diff(y(t), t), f), y(t), yy), 'Vars',[t, yy]); %2nd derivative of $f$
        y4_ = matlabFunction(subs(subs(subs(subs(y4, diff(y(t), t, t, t), y3), diff(y(t), t, t), y2), diff(y(t), t), f), y(t), yy), 'Vars',[t, yy]); %3rd derivative of $f$
        for i = 1:length(t_o)-1
            y_o(i+1) = y_o(i) + h*y1_(t_o(i), y_o(i)) + h^2/2*y2_(t_o(i), y_o(i)) + h^3/6*y3_(t_o(i), y_o(i)) + h^4/24*y4_(t_o(i), y_o(i)); %4th order taylor's formula
            fprintf("y(%g) = %g\n", i+1, y_o(i+1));
        end
end
end
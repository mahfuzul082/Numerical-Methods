function [fx_, lse] = curve_fit(x_, y_, degree)

syms x;
switch degree
    case '1'
        A = [length(x_) sum(x_); sum(x_) sum(x_.^2)]; %[X]
        b = [sum(y_); sum(x_.*y_)]; %{Y}
        a = A\b; %{A}
        fx_ = a(1) + a(2)*x; %function
        y_f = a(1) + a(2)*x_; %approximations
        lse = sum((y_ - y_f).^2); %lse
    case '2'
        A = [length(x_) sum(x_) sum(x_.^2); sum(x_) sum(x_.^2) sum(x_.^3); sum(x_.^2) sum(x_.^3) sum(x_.^4)]; %[X]
        b = [sum(y_); sum(x_.*y_); sum((x_.^2).*y_)]; %{Y}
        a = A\b; %{A}
        fx_ = a(1) + a(2)*x + a(3)*x^2; %function
        y_f = a(1) + a(2)*x_ + a(3)*x_.^2; %approximations
        lse = sum((y_ - y_f).^2); %lse
    case '3'
        A = [length(x_) sum(x_) sum(x_.^2) sum(x_.^3); sum(x_) sum(x_.^2) sum(x_.^3) sum(x_.^4); sum(x_.^2) sum(x_.^3) sum(x_.^4) sum(x_.^5); sum(x_.^3) sum(x_.^4) sum(x_.^5) sum(x_.^6)]; %[X]
        b = [sum(y_); sum(x_.*y_); sum((x_.^2).*y_); sum((x_.^3).*y_)]; %{Y}
        a = A\b; %{A}
        fx_ = a(1) + a(2)*x + a(3)*x^2 + a(4)*x^3; %function
        y_f = a(1) + a(2)*x_ + a(3)*x_.^2 + a(4)*x_.^3; %approximations
        lse = sum((y_ - y_f).^2); %lse
end
end

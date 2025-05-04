clear all; clc;

format longG
%input arguments
f = @(x) (cos(2*x)).^2 - x.^2;
%f_x = diff(f, x);
a = -10;
b = 0.5;
tlr = 1.e-10;
n_max = 1000;

%call the fixed point iteration function
[x_, fx_, n_itr, err_abs] = false_position(f, a, b, tlr, n_max);
[x_, fx_, n_itr, err_abs];

x_e = fzero(f, (a+b)./2)
x_err = abs(x_e - x_);
clear all; clc;

format longG
%input arguments
f = @(x) (cos(2*x)).^2 - x.^2;
%f_x = diff(f, x);
x_0 = 100;
tlr = 1.e-10;
n_max = 100;

%call the fixed point iteration function
[x_, fx_, n_itr, err_abs] = newton(f, x_0, tlr, n_max);
[x_, fx_, n_itr, err_abs];

x_e = fzero(f, x_0)
x_err = abs(x_e - x_);
clear all; clc;

format longG
%input arguments
f = @(x) exp(x) - x.^2;
%f_x = diff(f, x);
a = 0;
b = 0;
x_0 = -0.4;
x_1 = 0.4;
tlr = 1.e-10;
n_max = 100;

%call the fixed point iteration function
[x_, fx_, n_itr, err_abs] = secant(f, x_0, x_1, tlr, n_max);
[x_, fx_, n_itr, err_abs]

x_e = fzero(f, x_0)
x_err = abs(x_e - x_);
clear all; clc;

format longG
%input arguments
f = @(x) x^3 + 4*x^2 -10;
%f_x = diff(f, x);
a = 1;
b = 2;
tlr = 1.e-4;
n_max = 1000;

[x_, fx_, n_itr, err_abs] = bisection(f, a, b, tlr, n_max);
[x_, fx_, n_itr, err_abs];
x_e = fzero(f, (a+b)./2) %bisection, false position, chord
x_err = abs(x_e - x_);
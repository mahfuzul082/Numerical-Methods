function[x_, fx_, n_itr, err_abs] = myfzero(f, a, b, x_0, x_00, tlr, n_max, method)
switch method
    case 'b'
        [x_, fx_, n_itr, err_abs] = bisection(f, a, b, tlr, n_max);
    case 'n'
        [x_, fx_, n_itr, err_abs] = newton(f, x_0, tlr, n_max);
    case 'c'
        [x_, fx_, n_itr, err_abs] = chord(f, a, b, tlr, n_max);
    case 's'
        [x_, fx_, n_itr, err_abs] = secant(f, x_0, x_00, tlr, n_max);
    case 'f'
        [x_, fx_, n_itr, err_abs] = false_position(f, a, b, tlr, n_max);
end
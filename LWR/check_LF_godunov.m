for n = 1 : 32
    tra_LF = model_setup(1, 3, 1, 1, n*100, n*320);
    tra_LF = set_rho_ini(tra_LF, 'bellshape');
    tra_LF = set_lwr_relation(tra_LF, 'greenshields');
    tra_LF = solve_LF(tra_LF);
    tra_god = model_setup(1, 3, 1, 1, n*100, n*320);
    tra_god = set_rho_ini(tra_god, 'bellshape');
    tra_god = set_lwr_relation(tra_god, 'greenshields');
    tra_god = solve_godunov(tra_god);
    err_inf(n) = max(max(abs(tra_LF.rho - tra_god.rho)));
    err_L1(n) = sum(sum(abs(tra_LF.rho - tra_god.rho))) * ...
                tra_LF.dx * tra_LF.dt;
end
semilogy(1:n, err_L1, '.', 'MarkerSize', 20);
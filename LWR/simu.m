tra = model_setup(1, 1, 1, 1, 480, 640);
tra = set_rho_ini(tra, 'bellshape', 0.2, 0.8, 0.15);
tra = set_lwr_relation(tra, 'greenshields');
tra = solve_LF(tra);
plotfig(tra);
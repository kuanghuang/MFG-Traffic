tra = model_setup(1, 1, 1, 1, 15, 20);
tra = init(tra);
tras = solve_multigrid(tra, 5, @init);
plotfig(tras(6));

function tra = init(tra)
    tra = set_rho_ini(tra, 'bellshape', 0.8, 0.2, 0.15);
    tra.V_ter = zeros(tra.Nx, 1);
end
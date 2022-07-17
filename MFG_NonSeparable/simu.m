tra = model_setup(1, 3, 1, 1, 15, 60);
tra = init(tra);
tras = solve_multigrid(tra, 3, @init);
plotfig(tras(4));

function tra = init(tra)
    %tra = set_rho_ini(tra, 'bellshape', 0.8, 0.2, 0.15);
    tra = set_rho_ini(tra, 'bellshape');
    tra.V_ter = zeros(tra.Nx, 1);
end
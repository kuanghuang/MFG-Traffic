%parpool('local', 24)
spparms('spumoni', 0);
tra = model_setup(1, 3, 1, 1, 15, 60);
tra = init(tra);
m = 3;
tras = solve_multigrid(tra, m, @init);

for k = 1 : m
    tra_intpl = interpolate(tras(k), 2, @init);
    drho = tra_intpl.rho - tras(k+1).rho;
    du = tra_intpl.u - tras(k+1).u;
    h = tras(k+1).dx * tras(k+1).dt;
    err_L1(k) = h * (sum(sum(abs(drho))) + sum(sum(abs(du))));
    err_L2(k) = sqrt(h) * (norm(drho, 'F') + norm(du, 'F'));
    err_inf(k) = max(max(abs(drho))) + max(max(abs(du)));
end
%err_L1
%save('res.mat');
figure; plot(1:m, err_L1); title('L^1');
%figure; plot(1:m, err_L2); title('L^2');
%figure; plot(1:m, err_inf); title('L^\infty');

function tra = init(tra)
    %tra = set_rho_ini(tra, 'unifpert');
    tra = set_rho_ini(tra, 'bellshape');
    %tra.V_ter = tra.rho_ini - 0.5;
    tra.V_ter = zeros(tra.Nx, 1);
end
%   interpolate a model on small grids
%   to a new model on N times larger grids
function newtra = interpolate(tra, N, init)
    newtra = model_setup(tra.L, tra.T, tra.u_free, tra.rho_jam, ...
                         tra.Nx * N, tra.Nt * N);
    newtra = init(newtra);
    newtra.rho(:, 1) = newtra.rho_ini;
    newtra.rho(:, 2:end) = intpl(tra.rho(:, 2:end), N);
    newtra.u = intpl(tra.u, N);
    newtra.V(:, 1:end-1) = intpl(tra.V(:, 1:end-1), N);
    newtra.V(:, end) = newtra.V_ter;
end

function X = intpl(Xs, N)
    [Nx Nt] = size(Xs);
    X = zeros(Nx * N, Nt * N);
    for j = 1 : Nx
    for n = 1 : Nt
        X(N*(j-1)+1:N*j, N*(n-1)+1:N*n) = Xs(j,n) * ones(N,N);
    end
    end
end
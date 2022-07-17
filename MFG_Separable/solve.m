function tra = solve(tra, solver, type)
    Nx = tra.Nx;
    Nt = tra.Nt;
    %   initial guess given by values in tra
    rho = tra.rho;
    u = tra.u;
    V = tra.V;
    %   zip into a vector
    w0 = [reshape(rho, Nx*(Nt+1), 1); reshape(u, Nx*Nt, 1);...
     reshape(V, Nx*(Nt+1), 1)];
    %   solve by fsolve
    F = @(w) eqs(tra, w);
    options = optimoptions('fsolve', 'Algorithm', 'trust-region-dogleg',...
    'Display', 'iter', 'SpecifyObjectiveGradient', true, ...
    'CheckGradients', false, 'MaxIterations', 200);
    if type == 1
        [w fval exitflag output] = solver(F, w0, options);
    else
        F2 = @(w) eqs2(tra, w);
        w = solver(F, F2, w0);
    end
    %   unzip
    tra.rho = reshape(w(1:Nx*(Nt+1)), Nx, Nt+1);
    tra.u = reshape(w(Nx*(Nt+1)+1:Nx*(Nt+1)+Nx*Nt), Nx, Nt);
    tra.V = reshape(w(Nx*(Nt+1)+Nx*Nt+1:2*Nx*(Nt+1)+Nx*Nt), Nx, Nt+1);
end
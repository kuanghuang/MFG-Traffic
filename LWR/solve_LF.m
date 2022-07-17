%   Lax-Friedrichs solver for LWR model
function tra = solve_LF(tra)
    %   CFL number
    c = tra.dt / tra.dx;
    if c * tra.u_free > 1
        disp('CFL condition not satisfied');
        disp('Solver stopped');
        return
    end
    %   time matching
    tra.rho(:,1) = tra.rho_ini;
    for n = 1 : tra.Nt
        tra.u(:,n) = tra.vlf(tra.rho(:,n));
        for j = 1 : tra.Nx
            if j > 1 l = j - 1; else l = tra.Nx; end
            if j < tra.Nx r = j + 1; else r = 1; end
            tra.rho(j,n+1) = 0.5 * (tra.rho(l,n) + tra.rho(r,n)) -...
                0.5 * c * (tra.rho(r,n) * tra.u(r,n) -...
                tra.rho(l,n) * tra.u(l,n));
        end
    end
end
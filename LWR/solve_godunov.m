%   godunov solver for LWR model
%   need flux function tra.flf to be convex
function tra = solve_godunov(tra)
    %   maximum density for flux function
    rho_max = fminunc(@(rho) -tra.flf(rho), 0);
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
            lf = flux(tra.flf, tra.rho(l,n), tra.rho(j,n), rho_max);
            rf = flux(tra.flf, tra.rho(j,n), tra.rho(r,n), rho_max);
            tra.rho(j,n+1) = tra.rho(j,n) - c * (rf - lf);
        end
    end
end

function f = flux(flf, rho_left, rho_right, rho_max)
    if rho_left <= rho_right
        f = min(flf(rho_left), flf(rho_right));
    elseif rho_right < rho_max & rho_max < rho_left
        f = flf(rho_max);
    else
        f = max(flf(rho_left), flf(rho_right));
    end
end
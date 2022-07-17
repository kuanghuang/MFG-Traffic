function J = cost_traj(x0, tra)
    Nx = tra.Nx;
    Nt = tra.Nt;
    x = x0;
    J = 0;
    for n = 1 : Nt
        rhon = tra.rho(cur_cell(tra.L, tra.Nx, x), n);
        un = tra.u(cur_cell(tra.L, tra.Nx, x), n);
        x = x + un * tra.dt;
        %   ring road
        if x > tra.L
            x = x - tra.L;
        end
        J = J + tra.dt * F(rhon, un);
    end
end

function c = cur_cell(L, Nx, x)
    dx = L / Nx;
    c = floor(x / dx) + 1;
end

function res = F(rho, u)
    if u < 0
        res = 1e8;
    elseif u > 1
        res = 1e8;
    else
        res = u^2/2-u+rho*u;
    end
end
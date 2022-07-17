function traj = comp_traj(tra, N)
    %   initially cars are uniformly distributed
    dist = tra.L / N;
    x = linspace(0, tra.L-dist, N);
    traj = zeros(N, tra.Nt+1);
    traj(:, 1) = x;
    %   integrate dx/dt=u
    for n = 1 : tra.Nt
        for i = 1 : N
            u = tra.u(cur_cell(tra.L, tra.Nx, x(i)), n);
            x(i) = x(i) + u * tra.dt;
            %   ring road
            if x(i) > tra.L
                x(i) = x(i) - tra.L;
            end
            traj(i, n+1) = traj(i, n) + u * tra.dt;
        end
    end
end

function c = cur_cell(L, Nx, x)
    dx = L / Nx;
    c = floor(x / dx) + 1;
end
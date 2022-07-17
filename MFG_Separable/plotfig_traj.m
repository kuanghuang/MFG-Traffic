function mov = plotfig_traj(tra)
    N = 32;
    dist = tra.L / N;
    x = linspace(0, tra.L-dist, N);
    y = zeros(tra.Nt+1, N);
    y(1,:) = x;
    figure; hold on;
    for n = 1 : tra.Nt
        for i = 1 : N
            u = tra.u(cur_cell(tra.L, tra.Nx, x(i)), n);
            x(i) = x(i) + u * tra.dt;
            if x(i) > tra.L
                x(i) = x(i) - tra.L;
            end
            y(n+1, i) = y(n,i) + u * tra.dt;
        end
    end
    for i = 1 : N
        plot(linspace(0,tra.T,tra.Nt+1), y(:,i));
    end
end

function c = cur_cell(L, Nx, x)
    dx = L / Nx;
    c = floor(x / dx) + 1;
end
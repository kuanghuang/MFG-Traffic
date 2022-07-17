function plotfig_traj(tra)
    %   number of cars
    N = 32;
    traj = comp_traj(tra, N);
    for i = 1 : N
        plot(linspace(0,tra.T,tra.Nt+1), traj(i, :));
        hold on;
    end
end


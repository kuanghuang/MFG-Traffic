%   plot the evolution of density and velocity
%   as a movie
function mov = plotfig(tra)
    %   parameters
    x = linspace(tra.dx/2, tra.L-tra.dx/2, tra.Nx);
    uf = tra.u_free;
    rhoj = tra.rho_jam;
    
    hfig = figure;
    %   full screen or not
    set(gcf,'outerposition',get(0,'screensize'));
    %   speed of movie
    fps = 1;
    
    for n = 1 : fps : tra.Nt
        plot(x, tra.rho(:,n) / rhoj, 'LineWidth', 2, 'Color', 'b');
        hold on;
        plot(x, tra.u(:,n) / uf, 'LineWidth', 2, 'Color', 'r');
        hold off;
        xlim([0, tra.L]);
        ylim([0, 1]);
        legend('density', 'velocity');
        title("time = " + num2str((n-1)*tra.dt, '%-1.2f'));  
        mov(n) = getframe(hfig);
    end
end
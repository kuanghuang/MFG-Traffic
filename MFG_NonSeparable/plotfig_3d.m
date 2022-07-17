function plotfig_3d(tra)
    x = linspace(tra.dx/2, tra.L-tra.dx/2, tra.Nx);
    t = linspace(0, tra.T-tra.dt, tra.Nt);
    [T X] = meshgrid(t, x);
    mesh(T, X, tra.rho(:,1:tra.Nt));
    colormap('jet');
    set(gca, 'FontSize', 16);
    xlabel('time','FontSize',20);
    ylabel('space','FontSize',20);
    zlabel('density','FontSize',20);
end
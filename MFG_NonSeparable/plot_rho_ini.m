function plot_rho_ini(tra)
    x = linspace(tra.dx/2, tra.L-tra.dx/2, tra.Nx);
    plot(x, tra.rho_ini, 'LineWidth', 2);
    xlim([0,tra.L]);
    ylim([0, tra.rho_jam]);
    xlabel('$x$', 'FontSize', 28, ...
        'FontWeight','bold','Interpreter', 'latex');
    ylabel('$\rho_0(x)$', 'FontSize', 28, ...
        'FontWeight','bold', 'Interpreter', 'latex');
    %title('Initial Density');
end
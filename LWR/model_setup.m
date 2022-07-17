%  Set up a traffic flow model
%  ring road, single class
function traffic = model_setup(L, T, uf, rhoj, Nx, Nt)
    %   length of the road
    traffic.L = L;
    %   time of simulation
    traffic.T = T;
    %   free flow speed
    traffic.u_free = uf;
    %   jam density
    traffic.rho_jam = rhoj;
    %   spatial and time mesh size
    traffic.Nx = Nx;
    traffic.Nt = Nt;
    traffic.dx = L / Nx;
    traffic.dt = T / Nt;
    %   discretized density and velocity
    traffic.rho_ini = zeros(Nx, 1);
    traffic.rho = zeros(Nx, Nt+1);
    traffic.u = zeros(Nx, Nt);
end
function J = total_cost(tra)
    rho = tra.rho(:,1:tra.Nt);
    u = tra.u;
    J0 = u.^2/2 - u + rho.*u;
    J = sum(sum(J0)) * tra.dx * tra.dt;
end
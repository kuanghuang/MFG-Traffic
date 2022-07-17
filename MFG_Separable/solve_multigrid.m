%   multigrid solver
%   refine the grids N times
function tras = solve_multigrid(tra, N, init)
    %   base grid
    tras(1) = tra;
    
    for k = 1 : 2
        disp(['grid size : ' int2str(tras(k).Nx) 'x' int2str(tras(k).Nt)]); 
        tras(k) = solve(tras(k), @fsolve, 1);
        tras(k+1) = interpolate(tras(k), 2, init);
    end
    for k = 3 : N
        disp(['grid size : ' int2str(tras(k).Nx) 'x' int2str(tras(k).Nt)]); 
        tras(k) = solve(tras(k), @fsolve, 1);
        tras(k+1) = interpolate(tras(k), 2, init);
    end
    
    disp(['grid size : ' int2str(tras(N+1).Nx) 'x' int2str(tras(N+1).Nt)]);
    tras(N+1) = solve(tras(N+1), @fsolve, 1);
end
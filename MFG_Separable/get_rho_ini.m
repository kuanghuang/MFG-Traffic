function rho_ini = get_rho_ini(L, Nx, type)
    dx = L / Nx;
    
    if strcmpi(type, 'bellshape')
        sigma = 0.1;
        rho_ini = 0.05 + 0.9 * exp(-(linspace(-L/2+dx/2,L/2-dx/2,Nx)...
            .^2/(sigma^2)))';
    end
    
    if strcmpi(type, 'invbell')
        sigma = 0.1;
        rho_ini = 0.75 - 0.5 * exp(-(linspace(-L/2+dx/2,L/2-dx/2,Nx)...
            .^2/(sigma^2)))';
    end
    
    if strcmpi(type, 'rect')
        rho_ini = 0.25 * ones(Nx, 1);
        rho_ini(Nx/4+1 : 3*Nx/4) = 0.5 * ones(Nx/2, 1);
    end
    
    if strcmpi(type, 'tri')
        rho_ini = 0.5 * ones(Nx, 1)+0.25*sin(linspace(0,8*pi,Nx)');
    end
    
    if strcmpi(type, 'uniformperturb')
        rho_ini = 0.5*ones(Nx, 1)+0.05*rand(Nx,1);
    end
    
    if strcmpi(type, 'shockwave')
        rho_ini = 0.25 * ones(Nx, 1);
        for i = 2 : 2 : 4
            rho_ini((i-1)*Nx/4+1:i*Nx/4) = ...
                linspace(0.75, 0.25, Nx/4);
        end
    end
    
    if strcmpi(type, 'twopeak')
        sigma = 0.05;
        rho_ini = 0.2 * ones(Nx, 1);
        rho_ini = rho_ini + 0.15 * exp(-(linspace(-0.75*L+dx/2,0.25*L-dx/2,Nx)...
            .^2/(sigma^2)))';
        rho_ini = rho_ini + 0.15 * exp(-(linspace(-0.25*L+dx/2,0.75*L-dx/2,Nx)...
            .^2/(sigma^2)))';
        %rho_ini(66:135) = 0.05*ones(70,1);
    end
end
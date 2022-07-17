function tra = set_rho_ini(tra, type, varargin)
    
    if strcmpi(type, 'bellshape')
        %   default parameters
        rmin = 0.05;  rmax = 0.95;
        sigma = 0.1;
        %   user-specified parameters
        if nargin > 2
            rmin = varargin{1};
            rmax = varargin{2};
        end
        if nargin > 4
            sigma = varargin{3};
        end
        
        x = linspace(-tra.L/2+tra.dx/2, tra.L/2-tra.dx/2, tra.Nx);
        tra.rho_ini = rmin + (rmax-rmin) * exp(-x.^2/sigma^2);
    end
    
    if strcmpi(type, 'sinewave')
        %   default parameters
        nw = 2;
        %   user-specified parameters
        if nargin > 2
            nw = varargin{1};
        end
        tra.rho_ini = (1 + sin(linspace(0, nw*2*pi, tra.Nx))) / 2;
    end
    
    if strcmpi(type, 'unifpert')
        %   default parameters
        rhob = 0.5;
        pert = 0.05;
        nw = 1;
        %   user-specified parameters
        if nargin == 3
            rhob = varargin{1};
            pert = rhob / 10;
        end
        if nargin > 3
            rhob = varargin{1};
            pert = varargin{2};
        end
        if nargin > 4
            nw = varargin{3};
        end
        tra.rho_ini = rhob + pert * sin(linspace(0, nw*2*pi, tra.Nx));
    end
    
    if strcmpi(type, 'rectwave')
        %   default parameters
        rmin = 0.5;
        rmax = 0.75;
        %   user-specified parameters
        if nargin > 2
            rmin = varargin{1};
            rmax = varargin{2};
        end
        if mod(tra.Nx, 2) ~= 0
            disp('Error : Nx should be even!')
            return
        end
        tra.rho_ini = [rmin * ones(tra.Nx/2, 1);...
                       rmax * ones(tra.Nx/2, 1)]; 
    end
    
    tra.rho_ini = tra.rho_jam * reshape(tra.rho_ini, tra.Nx, 1);
end
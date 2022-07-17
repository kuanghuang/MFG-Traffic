function [F J] = eqs(tra, w)
    Nx = tra.Nx;  Nt = tra.Nt;  
    dx = tra.dx;  dt = tra.dt;
    c = tra.dt / tra.dx;
    uf = tra.u_free;
    rhoj = tra.rho_jam;
    %   unzip
    rho = reshape(w(1:Nx*(Nt+1)), Nx, Nt+1);
    u = reshape(w(Nx*(Nt+1)+1:Nx*(Nt+1)+Nx*Nt), Nx, Nt);
    V = reshape(w(Nx*(Nt+1)+Nx*Nt+1:2*Nx*(Nt+1)+Nx*Nt), Nx, Nt+1);
    %   functional value and gradient
    F = zeros(2*Nx*(Nt+1)+Nx*Nt, 1);
    J = sparse(2*Nx*(Nt+1)+Nx*Nt, 2*Nx*(Nt+1)+Nx*Nt);
    
    %   labels
    for n = 1 : Nt+1
    for j = 1 : Nx    
        prho(j,n) = Nx * (n - 1) + j;
        pu(j,n) = Nx * (Nt+1) + Nx * (n - 1) + j;
        pV(j,n) = Nx * (Nt+1) + Nx * Nt + Nx * (n - 1) + j;
    end
    end
    
    cnt = 0;
    cntJ = 0;
    magic_num = 3*Nx*(Nt+1)*8;
    Jrow = zeros(magic_num, 1);
    Jcol = zeros(magic_num, 1);
    Jval = zeros(magic_num, 1);
    
    %   initial condition
    for j = 1 : Nx
        cnt = cnt + 1;
        F(cnt) = rho(j,1) - tra.rho_ini(j);
        
        cntJ = cntJ + 1;
        Jrow(cntJ) = cnt;
        Jcol(cntJ) = prho(j,1);
        Jval(cntJ) = 1;
    end
    
    %   terminal condition
    for j = 1 : Nx
        cnt = cnt + 1;
        F(cnt) = V(j,Nt+1) - tra.V_ter(j);
        
        cntJ = cntJ + 1;
        Jrow(cntJ) = cnt;
        Jcol(cntJ) = pV(j,Nt+1);
        Jval(cntJ) = 1;
    end

    %   continuity equation LF scheme
    for n = 1 : Nt
    for j = 1 : Nx
        if j > 1 l = j-1; else l = Nx; end
        if j < Nx r = j+1; else r = 1; end
        
        cnt = cnt + 1;
        F(cnt) = rho(j,n+1) - 0.5 * (rho(l,n) + rho(r,n)) + 0.5 * c *...
                (rho(r,n) * u(r,n) - rho(l,n) * u(l,n));
          
        cntJ = cntJ + 1;
        Jrow(cntJ) = cnt;
        Jcol(cntJ) = prho(j,n+1);
        Jval(cntJ) = 1;
        
        cntJ = cntJ + 1;
        Jrow(cntJ) = cnt;
        Jcol(cntJ) = prho(l,n);
        Jval(cntJ) = -0.5 - 0.5 * c * u(l,n);
        
        cntJ = cntJ + 1;
        Jrow(cntJ) = cnt;
        Jcol(cntJ) = prho(r,n);
        Jval(cntJ) = -0.5 + 0.5 * c * u(r,n);
        
        cntJ = cntJ + 1;
        Jrow(cntJ) = cnt;
        Jcol(cntJ) = pu(l,n);
        Jval(cntJ) = -0.5 * c * rho(l,n);
        
        cntJ = cntJ + 1;
        Jrow(cntJ) = cnt;
        Jcol(cntJ) = pu(r,n);
        Jval(cntJ) = 0.5 * c * rho(r,n);
    end
    end
    
    %   HJB equations Dynamic Programming
    for n = Nt : -1 : 1
    for j = 1 : Nx
        if j < Nx r = j+1; else r = 1; end
        
        cnt = cnt + 1;
        u_min = uf * (1 - uf * (V(r,n+1) - V(j,n+1))/dx);
        if u_min < 0
            F(cnt) = u(j,n);
            cntJ = cntJ + 1;
            Jrow(cntJ) = cnt;
            Jcol(cntJ) = pu(j,n);
            Jval(cntJ) = 1;
        elseif u_min > uf
            F(cnt) = u(j,n) - uf;
            cntJ = cntJ + 1;
            Jrow(cntJ) = cnt;
            Jcol(cntJ) = pu(j,n);
            Jval(cntJ) = 1;
        else
            F(cnt) = u(j,n) / uf + ...
                    uf * (V(r,n+1) - V(j,n+1)) / dx - 1;
        
            cntJ = cntJ + 1;
            Jrow(cntJ) = cnt;
            Jcol(cntJ) = pu(j,n);
            Jval(cntJ) = 1 / uf;
        
            cntJ = cntJ + 1;
            Jrow(cntJ) = cnt;
            Jcol(cntJ) = pV(j,n+1);
            Jval(cntJ) = -uf / dx;
        
            cntJ = cntJ + 1;
            Jrow(cntJ) = cnt;
            Jcol(cntJ) = pV(r,n+1);
            Jval(cntJ) = uf / dx;
        end
        
        cnt = cnt + 1;
        F(cnt) = (V(j,n+1) - V(j,n)) / dt + ...
                 u(j,n) * (V(r,n+1) - V(j,n+1)) / dx +...
                 (u(j,n)/uf)^2 / 2 - u(j,n)/uf +...
                 rho(j,n)/rhoj;
        
        cntJ = cntJ + 1;
        Jrow(cntJ) = cnt;
        Jcol(cntJ) = pV(j,n+1);
        Jval(cntJ) = 1 / dt - u(j,n) / dx;
        
        cntJ = cntJ + 1;
        Jrow(cntJ) = cnt;
        Jcol(cntJ) = pV(j,n);
        Jval(cntJ) = -1 / dt;
        
        cntJ = cntJ + 1;
        Jrow(cntJ) = cnt;
        Jcol(cntJ) = pV(r,n+1);
        Jval(cntJ) = u(j,n) / dx;
        
        cntJ = cntJ + 1;
        Jrow(cntJ) = cnt;
        Jcol(cntJ) = prho(j,n);
        Jval(cntJ) = 1 / rhoj;
        
        cntJ = cntJ + 1;
        Jrow(cntJ) = cnt;
        Jcol(cntJ) = pu(j,n);
        Jval(cntJ) = (u(j,n)/uf - 1) / uf...
                   + (V(r,n+1) - V(j,n+1)) / dx;
    end
    end
    
    J = sparse(Jrow(1:cntJ), Jcol(1:cntJ), Jval(1:cntJ));
end
function tra = set_lwr_relation(tra, type)
    uf = tra.u_free;
    rhoj = tra.rho_jam;
    if strcmpi(type, 'greenshields')
        tra.vlf = @(rho) uf * (1 - rho / rhoj);
        tra.flf = @(rho) rho .* tra.vlf(rho);
    end
    
    if strcmpi(type, 'smnewell-daganzo')
        b = 1.0 / 3.0;
        lambda = 0.1;
        c = 0.078 * rhoj * uf;
        g = @(y) sqrt(1 + ((y-b)/lambda).^2);
        tra.flf = @(rho) c * (g(0) + (g(1) - g(0)) * rho/rhoj - ...
                   g(rho/rhoj));
        tra.vlf = @(rho) tra.flf(rho) ./ rho;
    end
end
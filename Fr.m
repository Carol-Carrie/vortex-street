%% 

clear all;
clc;

p0 = 100000;
Rd = 287; 
cp = 1004; 
g = 9.81; 

file=ncinfo('20220217.nc');
u=ncread('20220217.nc','u');
v=ncread('20220217.nc','v');
T=ncread('20220217.nc','t');


P=[750 775 800 825 850 875 900 925 950 975 1000];%hPa
P1=P*100;%Pa
p_expanded = repmat(permute(P1, [3, 1, 2]), [23, 19, 1]);% 


U = sqrt(u.^2 + v.^2);


theta = T .* (p0./p_expanded).^(Rd/cp);


p00 = 101325; % Pa
z0 = 0; % m
T0 = 273; % K
z = z0 - (Rd * T0 / g) * log(P1 / p00);


dtheta_dz = zeros(size(theta));
for i = 1:size(theta, 1)
    for j = 1:size(theta, 2)
        dtheta_dz(i, j, :) = gradient(squeeze(theta(i, j, :)), z);
    end
end


N2 = (g./theta) .* dtheta_dz;

%%

H = 1950; % m

hc = zeros(23, 19);

for i = 1:23
    for j = 1:19
        
        U_current = squeeze(U(i, j, :)); 
        
        N2_subset = N2(9:12, 5:7, :); 
        N2_current = squeeze(mean(mean(N2_subset, 1), 2));
        
        z_col = z(:); 
        
       
        if length(z_col) ~= length(U_current) || length(z_col) ~= length(N2_current)
            error('z_col 和 U_current/N2_current');
        end
        

        f = @(hc) 0.5 * interp1(z_col, U_current, hc)^2 - ...
            integral(@(zz) interp1(z_col, N2_current, zz) .* (H - zz), hc, H);
        

          hc_initial_guess = z_col(6);
         try
             hc(i, j) = fzero(f, hc_initial_guess);
         catch ME
             warning('failure', i, j, ME.message);
             hc(i, j) = NaN;
        end
    end
end

%% 
Fr = 1 - hc / H; 


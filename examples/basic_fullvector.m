
clear all;
close all;

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = linspace(3.305,3.44,10);          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute



for j=1:length(n2)
    
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2(j),n3],[h1,h2,h3], ...
                                            rh,rw,side,dx,dy); 
    % First consider the fundamental TE mode:

    [Hx,Hy,neff] = wgmodes(lambda,n2(j),nmodes,dx,dy,eps,'000A');

    fprintf(1,'neff = %.6f\n',neff);
    neff_store(j) = neff;
    
    figure;
    subplot(121);
    contourmode(x,y,Hx);
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end

    subplot(122);
    contourmode(x,y,Hy);
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end


end

figure;
plot(neff_store)
title('Neff')
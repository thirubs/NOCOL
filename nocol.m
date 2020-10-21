function [W,H,iter] = nocol(V,W0,H0,maxiter)
%% Initialization
W = W0; H = H0;

no_of_rows = size(W,1);
V = double(V);
epsilon = 0.0000001; % to ensure non-negativity


%% Main Loop
for iter=1:maxiter 
	[W,H] = goiter(V,W,H,iter,epsilon);   
end


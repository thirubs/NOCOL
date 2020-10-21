X = sprand(50,30,0.01); % define the input matrix (using tensor toolbox tensor data structure)

N = ndims(X);
maxiter = 25; % maximum number of iterations
J = 25; % rank of the matrix

% Random initialization of factor matrices
Uinit = cell(N,1);    
for n = 1:N 
    Uinit{n} = normalize_factor(rand(size(X,n),J),2);        
end

W_O = Uinit{1};
H_O = Uinit{2}';

%% NOCOL
[W,H] = nocol(X,W_O,H_O,maxiter);

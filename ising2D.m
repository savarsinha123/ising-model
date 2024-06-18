nrows = 300;
ncols = 300;
time_steps = 1e6;
plot_intervals = 100;
temp = 0.1;

% Initialization
spins = randi([1, 2], nrows, ncols);
spins = 2 * spins - 3;
hamiltonian = calculateHamiltonian(spins);
grid = plotGrid(spins);

% Calculations
for i = 1:time_steps
    [spins, hamiltonian] = updateSpins(spins, temp, hamiltonian);
    if mod(i, time_steps/plot_intervals) == 0
        set(grid, 'CData', spins);
        drawnow;
    end
end

disp("The normalized hamiltonian is " + hamiltonian / (nrows * ncols))

function energy = nearestNeighbor(spins, i, j)
    [nrows, ncols] = size(spins);
    energy = spins(mod(i - 2, nrows) + 1, j) ...
    + spins(mod(i, nrows) + 1, j) ... 
    + spins(i, mod(j - 2, ncols) + 1) + spins(i, mod(j, ncols) + 1);
end

function hamiltonian = calculateHamiltonian(spins)
    hamiltonian = 0;
    dims = size(spins);
    for i = 1:dims(1)
        for j = 1:dims(2)
            s = spins(i, j);
            hamiltonian = hamiltonian - s * nearestNeighbor(spins, i, j);
        end
    end
    hamiltonian = hamiltonian / 2;
end

function [spins, hamiltonian] = updateSpins(spins, temp, hamiltonian)
    [nrows, ncols] = size(spins);
    i = randi(nrows);
    j = randi(ncols);

    % flip spin
    s = -spins(i, j);
    dE = -2 * s * nearestNeighbor(spins, i, j);
    if dE <= 0
        spins(i, j) = s;
        hamiltonian = hamiltonian + dE;
    else
        prob = exp(-dE/temp);
        if rand() < prob
            spins(i, j) = s;
            hamiltonian = hamiltonian + dE;
        end
    end
end
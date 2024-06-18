nrows = 100;
ncols = 100;
time_steps = 1e5;
temps = 0:0.1:6;

% Calculations
hamiltonians = [];
for t = temps
    % Initialization
    spins = randi([1, 2], nrows, ncols);
    spins = 2 * spins - 3;
    hamiltonian = calculateHamiltonian(spins);
    for i = 1:time_steps
        [spins, hamiltonian] = updateSpins(spins, t, hamiltonian);
    end
    hamiltonians(end + 1) = hamiltonian;
end

% Plot normalized hamiltonian vs temperature
plot(temps, hamiltonians / (nrows * ncols));
hold on;

% Theoretical value of phase transition temperature
t_critical = 2/log(1 + sqrt(2));

% Plot the vertical line using the xline function
xline(t_critical, 'r', 'LineWidth', 2);
hold off;

xlabel("Temperature")
ylabel("Evolved Normalized Hamiltonian")
title("Hamiltonian vs Temperature")

saveas(gcf,'phase_transition.png')

% Function declarations
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
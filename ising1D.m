n = 50;
time_steps = 100000;
temp = 1;

% Initialization
spins = randi([1, 2], 1, n);
spins = 2 * spins - 3;

% Graphics
% Visualize the array
h = imagesc(spins);

% Set the colormap to map -1 to black and +1 to white
colormap([0 0 0; 1 1 1]);

% Set the color limits to ensure proper mapping
caxis([-1 1]);

% Remove axis labels for a cleaner look
axis equal tight off;

% Add a title
title('Visualization of -1s and +1s as Black/White Squares');

% Calculations
for i = 1:time_steps
    spins = updateSpins(spins, temp);
    if mod(i, time_steps/1000) == 0
        set(h, 'CData', spins);
        drawnow;
    end
end


function spins = updateSpins(spins, temp)
    n = length(spins);
    i = randi(n);

    % flip spin
    s = -spins(i);
    dE = -2 * s * spins(mod(i - 2, n) + 1) - s * spins(mod(i, n) + 1);
    if dE <= 0
        spins(i) = s;
    else
        prob = exp(-dE/temp);
        if rand() < prob
            spins(i) = s;
        end
    end
end
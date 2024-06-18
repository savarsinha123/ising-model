function grid = plotGrid(spins)
    % Visualize the array
    grid = imagesc(spins);
    
    % Set the colormap to map -1 to black and +1 to white
    colormap([0 0 0; 1 1 1]);
    
    % Set the color limits to ensure proper mapping
    caxis([-1 1]);
    
    % Remove axis labels for a cleaner look
    axis equal tight off;

    plot_title = "Ising Model: size = " + num2str(size(spins));
    
    % Add a title
    title(plot_title);
end
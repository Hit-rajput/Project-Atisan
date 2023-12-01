
population_size = 4;
dimensions = 6;
generations = 3;
F = 0.5;
CR = 0.7;



population = rand(population_size, dimensions);

for generation = 1:generations
    fprintf('Generation %d/%d\n', generation, generations);
    for i = 1:population_size
        % Mutation
        idxs = setdiff(1:population_size, i);
        chosen_idxs = idxs(randperm(length(idxs), 3));
        a = population(chosen_idxs(1), :);
        b = population(chosen_idxs(2), :);
        c = population(chosen_idxs(3), :);
        mutant = a + F * (b - c);
        mutant = min(max(mutant, 0), 1); % Ensuring values are within 0-1 bounds

        % Crossover
        cross_points = rand(1, dimensions) < CR;
        if ~any(cross_points)
            cross_points(randi([1, dimensions])) = true;
        end
        trial = population(i, :);
        trial(cross_points) = mutant(cross_points);

        % Human-influenced Selection
        if human_evaluated_objective(trial) > human_evaluated_objective(population(i, :))
            population(i, :) = trial;
        end
    end
end


objective_values = arrayfun(@(i) objective_function(population(i, :)), 1:population_size);
[best_score, best_index] = min(objective_values);
best_individual = population(best_index, :);

fprintf('Best Individual (Desired [R, G, B], Undesired [R, G, B]): [%f, %f, %f, %f, %f, %f]\n', best_individual);
fprintf('Best Score: %f\n', best_score);


function score = human_evaluated_objective(x)
    fprintf('Evaluate the solution (Desired [R, G, B], Undesired [R, G, B]): [%f, %f, %f, %f, %f, %f]\n', x);
    fprintf('Objective function value: %f\n', objective_function(x));
    ColorSeperation(x(1:3), x(4:6), '/MATLAB Drive/Computer_vision/Project/Colour_seperation_Matlab 2/IDE/test_image_1.png');
    score = input('Enter a score (higher is better): ');
end



function value = objective_function(x)
    desired_color = x(1:3);
    undesired_color = x(4:6);
    value = -sum((desired_color - undesired_color).^2);
end

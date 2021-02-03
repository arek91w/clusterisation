// dokumentacja mówi żeby to wstawić w skryptach, gdzie używa się rand()
rand('seed',getdate('s'));




function z = manhattan_distance(a, b)
    z = sum(abs(a - b));
endfunction


// funkcja wybierająca n losowych liczb z wektora a bez zwracania
function z = choose_random_numbers(a, n)
    z = []
    if n <= length(a) then
        for i = 1:n
            index = floor(rand() * length(a)) + 1;
            z(i) = a(index);
            a = [a(1:index - 1), a(index + 1:$)];
        end
    end
endfunction


function z = kmeans(data, k, max_iterations)
    data_length = length(data(:, 1));
    centroids = data(choose_random_numbers(1:data_length, k), :);
    iteration = 1;
    centroids_are_moving = %T;
    
    while centroids_are_moving & iteration <= max_iterations
        for i = 1:data_length
            distances_to_centroids = [];
            for j = 1:k
                distances_to_centroids(j) = manhattan_distance(data(i, :), centroids(j, :));
            end
            [value, index] = min(distances_to_centroids);
            z(i) = index;
        end
        
        // wyznaczamy nowe centroidy
        old_centroids = centroids;
        new_centroids = [];
        for i = 1:k
            // wybieramy indeksy punktów danej grupy
            indices = find(z == i);

            new_centroids = [new_centroids; mean(data(indices, :), "r")];
        end
        centroids = new_centroids;

        if and(old_centroids == centroids) then
            centroids_are_moving = %F
        end
        iteration = iteration + 1;
        
    end
endfunction



function z = how_many(a)
    z = [];
    for i = 1:length(a)
        if length(find(z(:, 1) == a(i))) == 0 then
            count = length(find(a == a(i)));
            z = [z; [a(i), count]]
        end
    end
endfunction




loadmatfile('ed-p02.mat');

case_one_clusters = kmeans(Patterns, 4, 100);
case_two_clusters = kmeans(Patterns2, 4, 100);


disp("Przypadek pierwszy:");
disp(case_one_clusters);
disp(how_many(case_one_clusters));

disp("Przypadek drugi:");
disp(case_two_clusters);
disp(how_many(case_two_clusters));

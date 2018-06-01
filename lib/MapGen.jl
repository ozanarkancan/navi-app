module MapGen

include("SAILx/src/maze.jl")

function random_map(h, w)
    maze, available = generate_maze(h, w; numdel=2)
    navimap = generate_navi_map(maze, "RANDOMMAZE"; itemcountprobs=[0.0 0.0 0.05 0.05 0.1 0.1 0.1 0.1 0.1 0.2 0.2], iprob=0.6)
end

end

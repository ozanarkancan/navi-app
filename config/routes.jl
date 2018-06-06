using Router, App, MapGen, Agent, JSON

route("/", named = :root) do
    Router.serve_static_file("/main.html")
end

route("/rmap", method=POST, named = :randommap) do
    height = parse(Int, @params(:h))
    width = parse(Int, @params(:w))
    global navimap = MapGen.random_map(height, width)
    respond(Dict(:json => JSON.json(Dict(:name => navimap.name, :nodes => navimap.nodes, :edges => navimap.edges))))
end

route("/execute", method=POST, named = :predict) do
    global navimap
    result = Agent.predict(@params(:instruction), eval(parse(@params(:initial))), navimap)
    respond(Dict(:json => JSON.json(Dict(:path => convert(Array{Int}, result)))))
end

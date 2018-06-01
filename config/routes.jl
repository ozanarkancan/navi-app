using Router, App, MapGen, Agent, JSON

route("/", named = :root) do
    Router.serve_static_file("/main.html")
end

route("/rmap", method=POST, named = :randommap) do
    height = eval(parse(@params(:h)))
    width = eval(parse(@params(:w)))
    global navimap = MapGen.random_map(height, width)
    println(navimap)
    respond(Dict(:action => :root, :json => JSON.json(Dict(:navimap => navimap))))
end

route("/execute", method=POST, named = :predict) do
    global navimap
    result = Agent.predict(@params(:instruction), (3, 2, 0), navimap)
    println(result)
    redirect_to("/")
end

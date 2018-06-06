module Agent

using JLD, App
include("flex.jl")
include("util.jl")

global vocab = load(joinpath(App.config.server_document_root, "models/vocab_sail.jld"), "vocab")

function loadmodel(fname; flex=true)
    w = Dict()
    d = load(fname, "weights")
    for k in keys(d)
        if flex && startswith(k, "filter")
            w[k] = d[k]
        else
            w[k] = d[k]
        end
    end
    return w
end

global models = [loadmodel(joinpath(App.config.server_document_root, "models/sail_vtest_jelly2_"*"$i"*"_vtest_grid_l.jld")) for i=1:10]
#global models = [loadmodel(joinpath(App.config.server_document_root, "models/sailx_base_"*"$i"*".jld")) for i=1:10]

function predict(instruction, startpos, navimap)
    global models
    global vocab

    ins_text = split(strip(instruction), "_")
    words = ins_arr(vocab, ins_text)
    args = Dict()
    args["hidden"] = 120
    args["embed"] = 120
    args["limactions"] = 35
    args["bs"] = 1
    args["wvecs"] = false
    args["greedy"] = true
    args["percp"] = true
    args["preva"] = true
    args["worldatt"] = 100
    args["attinwatt"] = 0
    args["att"] = false
    args["inpout"] = true
    args["prevaout"] = false
    args["beam"] = true
    args["attout"] = false
    args["beamsize"] = 10
    args["encoding"] = "grid"
    args["atype"] = Array{Float32}

    predict_beam(models, words, navimap, startpos; args=args)
end

end

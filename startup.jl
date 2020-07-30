"
 startup julia script

 * create link
 ln -nfs ~/dotfiles/startup.jl ~/.julia/config/startup.jl 
"

ENV["JULIA_EDITOR"] = "vim"

# for OhMyREPL
atreplinit() do repl
    try
        @eval using OhMyREPL
    catch e
        @warn "error while importing OhMyREPL" e
    end
end

# For Revise.jl
atreplinit() do repl
    try
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch e
        @warn(e.msg)
    end
end

# For BenchmarkTools
atreplinit() do repl
    try
        @eval using BenchmarkTools
    catch e
        @warn(e.msg)
    end
end


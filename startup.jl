"
 startup script

 author: Atsushi Sakai
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
    catch
    end
end


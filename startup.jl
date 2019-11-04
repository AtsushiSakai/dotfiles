"
 startup script

 author: Atsushi Sakai
"

ENV["JULIA_EDITOR"] = "vim"

# For Revise.jl
atreplinit() do repl
    try
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch
    end
end


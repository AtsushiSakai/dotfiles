"
 startup julia script

 * create link
 ln -nfs ~/dotfiles/startup.jl ~/.julia/config/startup.jl 
"

ENV["JULIA_EDITOR"] = "vim"
try
    ENV["PYTHON"]=Sys.which("python3")
catch
    ENV["PYTHON"]=""
end

# for OhMyREPL
atreplinit() do repl
    try
        @eval using OhMyREPL
    catch e
        @warn "error while importing OhMyREPL" e
    end
end

# For Revise.jl
try
    using Revise
catch e
    @warn(e.msg)
end


function recursive_includet(filename)
    already_included = copy(Revise.included_files)
    includet(filename)
    newly_included = setdiff(Revise.included_files, already_included)
    for (mod, file) in newly_included
        Revise.track(mod, file)
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

# For PackageCompiler.jl
try
    using PackageCompiler
catch e
    @warn(e.msg)
end

@eval using Pkg

DEFAULT_PKGS = [:OhMyREPL, :Revise, :BenchmarkTools, :PyPlot]

function install_default_pkgs()
    println("Installing default packages to latest ones...")
    for pkg in DEFAULT_PKGS
        Pkg.add(String(pkg))
    end
end

function generate_default_sysimage()

    println("Updating default packages to latest ones...")
    for pkg in DEFAULT_PKGS
        println("Updating $(String(pkg))")
        Pkg.update(String(pkg))
    end

    println("Restore sysimage once...")
    try
        restore_default_sysimage()
    catch e
        println(e.msg)
    end

    create_sysimage(DEFAULT_PKGS;replace_default=true)

    println("Done!!. If you want to restore default sysimage, run `restore_default_sysimage()`")

end


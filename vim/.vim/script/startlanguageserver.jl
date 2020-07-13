import Pkg
using LanguageServer, LanguageServer.SymbolServer

envpath = dirname(Pkg.Types.Context().env.project_file)

const DEPOT_DIR_NAME = ".julia"
depotpath = if Sys.iswindows()
    joinpath(ENV["USERPROFILE"], DEPOT_DIR_NAME)
else
    joinpath(ENV["HOME"], DEPOT_DIR_NAME)
end

runserver()


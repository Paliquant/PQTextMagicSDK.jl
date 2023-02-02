# setup internal paths -
_PATH_TO_SRC = dirname(pathof(@__MODULE__))

# load external modules -
using HTTP

# load my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"))
include(joinpath(_PATH_TO_SRC, "Factory.jl"))
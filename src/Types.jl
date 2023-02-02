# define abstract model types -
abstract type PQAbstractTextMagicEndpointModel end

# define concrete endpoint types -
mutable struct PQSendSingleTextMessageEndpointModel <: PQAbstractTextMagicEndpointModel

    # data -
    # ...

    # constructor -
    PQSendSingleTextMessageEndpointModel() = new()
end
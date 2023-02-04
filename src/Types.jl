# define abstract model types -
abstract type PQAbstractTextMagicEndpointModel end
abstract type PQAbstractTextMagicUserModel end

# define concrete endpoint types -
mutable struct PQSendSingleTextMessageEndpointModel <: PQAbstractTextMagicEndpointModel

    # data -
    # ...

    # constructor -
    PQSendSingleTextMessageEndpointModel() = new()
end

# define the user model -
mutable struct PQTextMagicUserModel <: PQAbstractTextMagicUserModel

    # data -
    apikey::String
    username::String

    # constructor -
    PQTextMagicUserModel() = new()
end
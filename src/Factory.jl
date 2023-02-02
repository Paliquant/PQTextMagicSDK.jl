"""
    build(enpoint_model_type::Type{T},  
        options::Dict{String,Any}) -> PQAbstractTextMagicEndpointModel where T<:PQAbstractTextMagicEndpointModel

Builds a TextMagic API endpoint model using the data stored in the options dictionary
"""
function build(endpoint_model_type::Type{T},  
    options::Dict{String,Any})::PQAbstractTextMagicEndpointModel where T<:PQAbstractTextMagicEndpointModel

    # initialize -
    model = eval(Meta.parse("$(endpoint_model_type)()")) # empty trader model -

    # for the result of the fields, let's lookup in the dictionary.
    # error state: if the dictionary is missing a value -
    for field_name_symbol ∈ fieldnames(endpoint_model_type)
        
        # skip apikey - we already set that
        if (field_name_symbol != :apikey)
            
            # convert the field_name_symbol to a string -
            field_name_string = string(field_name_symbol)
        
            # check the for the key -
            if (haskey(options,field_name_string) == false)
                throw(ArgumentError("dictionary is missing: $(field_name_string)"))    
            end

            # get the value -
            value = options[field_name_string]

            # set -
            setproperty!(model,field_name_symbol,value)
        end
    end

    # return -
    return model
end
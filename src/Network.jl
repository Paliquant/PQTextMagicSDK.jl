function _http_post_call_with_url(url::String, user::PQTextMagicUserModel, data::Dict{String,Any})::Some

    try 

        # initialize -
        username = user.username;
        apikey = user.apikey

        # make the call -
        response = HTTP.request("POST","$(url)",
            ["Content-Type"=>"application/json","X-TM-Username"=>"$(username)",
            "X-TM-Key"=>"$(apikey)"], 
    	    JSON.json(data))

        # return the body -
        return Some(String(response.body))

    catch error

        # get the original error message -
        error_message = sprint(showerror, error, catch_backtrace())
        vl_error_obj = ErrorException(error_message)

        # Package the error -
        return Some(vl_error_obj)
    end
end

function _process_textmagic_response(model::Type{T}, 
    response::String)::Tuple where T<:PQAbstractTextMagicEndpointModel

    # setup type handler map -> could we put this in a config file to register new handlers?
    type_handler_dict = Dict{Any,Function}()
    type_handler_dict[PQSendSingleTextMessageEndpointModel] = _process_single_text_message_call_response

    # lookup the type -
    if (haskey(type_handler_dict, model) == true)
        handler_function = type_handler_dict[model]
        return handler_function(response);
    end

    # default -
    return nothing
end

function api(model::Type{T}, complete_url_string::String, user::PQTextMagicUserModel, parameters::Dict{String,Any};
    handler::Function = _process_textmagic_response)::Tuple where T<:PQAbstractTextMagicEndpointModel

    # execute -
    result_string = _http_post_call_with_url(complete_url_string, user, parameters) |> check

    # process and return -
    return handler(model, result_string)
end


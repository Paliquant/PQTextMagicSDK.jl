function _process_single_text_message_call_response(body::String)

    # convert to JSON -
    request_body_dictionary = JSON.parse(body)

    # check: do we have a code element?
    response_dictionary = Dict{String,Any}()
    if (haskey(request_body_dictionary, "code") == true)

        # ok: if we get here, then we have a code 400 and 401 - which means an error of some sort
        response_key_array = []
        if (request_body_dictionary["code"] == 400)
            
            # setup key array -
            response_key_array = [
                "code", "message", "errors"
            ];

        elseif (request_body_dictionary["code"] == 401)

            # setup key array -
            response_key_array = [
                "code", "message"
            ];
        end

        # populate the response_dictionary -
        for key ∈ response_key_array
            response_dictionary[key] = request_body_dictionary[key]
        end

        # return -
        return response_dictionary;
    end

    # populate the response_dictionary -
    # check: the response does *not* have a code element -
    response_key_array = ["id", "href", "type", "sessionId", "bulkId", "messageId", "scheduleId", "chatId"];
    for key ∈ response_key_array
        response_dictionary[key] = request_body_dictionary[key]
    end

    # return -
    return response_dictionary;
end
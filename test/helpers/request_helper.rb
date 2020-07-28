module Requests
    module JsonHelpers
        def json_parse response
            JSON.parse(response.body)
        end            
    end        
end    
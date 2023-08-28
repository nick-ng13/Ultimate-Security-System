function postRequest(url, headers, body)
    http.post(url, headers, body, function(code, data)
        if (code < 0) then
            print("HTTP request failed")
        end
    end)
end

url = 'http://54.177.203.81:8080/'
header = 'Content-Type: application/json\r\n'
body = ""

for param, value in pairs(t) do -- concatenates entries in t to fill body
    body = body..value
end

postRequest(url, header, '{"body":"'..body..'"}')

for k in pairs(t) do    -- empties out t before next call
    t[k] = nil
end

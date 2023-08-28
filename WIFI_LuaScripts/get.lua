function getRequest(url)
    http.get(url, nil, function(code, data)
        if (code < 0) then
            print("request failed")
        else
            if (code == 210) then                   -- if return code is 210
                print("t")                          -- return a t
            else
                print("f")                          -- else return an f
            end
        end
    end)
end

url = 'http://54.177.203.81:8080/'

getRequest(url)

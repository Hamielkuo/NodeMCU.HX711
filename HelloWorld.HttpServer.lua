sv = net.createServer(net.TCP, 30)  
-- Server listen on 80
-- Print HTTP headers to console
sv:listen(80,function(c)  
    c:on("receive", function(conn, payload)
        print(payload)
        weight=0
        local msg = '{"msg":"ok"}'
        if (string.find(payload, "POST /scale/tare") ~= nil) then
            tare(10)
            msg='{"msg":"tare ok"}'
        elseif (string.find(payload, "POST /scale/weight") ~= nil) then
            weight=getWeight()
            msg=string.format('{"msg":"weight %s"}',weight)
        end
        
        conn:send(cjson.encode(msg))
        conn:close()
    end)
end)  

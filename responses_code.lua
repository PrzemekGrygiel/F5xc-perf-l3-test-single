-- example script that demonstrates use of setup() to pass
-- data to and from the threads

local counter = 1
local threads = {}

function setup(thread)
   thread:set("id", counter)
   table.insert(threads, thread)
   counter = counter + 1
end

function init(args)
   requests  = 0
   response_code_200 = 0
   response_code_502 = 0
   response_code_503 = 0
   response_code_408 = 0
   rc403 = 0
   response_code_other = 0
end

function request()
   requests = requests + 1
   return wrk.request()
end

function response(status, headers, body)
   if status == 200 then
      response_code_200 = response_code_200 + 1
   elseif status == 502 then
      response_code_502 = response_code_502 + 1
   elseif status == 503 then
      response_code_503 = response_code_503 + 1
   elseif status == 408 then
      response_code_408 = response_code_408 + 1
   elseif status == 403 then
      rc403 = rc403 + 1
   else
      response_code_other = response_code_other + 1
   end
end

function done(summary, latency, requests)
   for index, thread in ipairs(threads) do
      local id = thread:get("id")
      local response_code_200 = thread:get("response_code_200")
      local response_code_502 = thread:get("response_code_502")
      local response_code_503 = thread:get("response_code_503")
      local response_code_408 = thread:get("response_code_408")
      local rc403 = thread:get("rc403")
      local response_code_other = thread:get("response_code_other")
      local msg = "%d,%d,%d,%d,%d,%d,%d"
      print(msg:format(id,response_code_200, response_code_503, response_code_502, response_code_408, rc403, response_code_other))
   end
end

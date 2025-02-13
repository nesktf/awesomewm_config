-- Libraries
local mp = require("mp")

--function getHostname()
--  local host_file = io.open("/etc/hostname", "r")
--  io.input(host_file)
--  local f_read = io.read()
--  io.close(host_file)
--  return f_read
--end

-- Set Hostname dependent profile
--local host = getHostname()
--mp.osd_message("Loading "..host.." profile")
--mp.commandv('apply-profile', "default_"..host)

-- Enable loop on <= 30 sec vids
mp.observe_property('duration', 'number', function(_, dur)
  if dur and dur < 31 then
    --mp.osd_message("Loop auto enabled")
    mp.set_property('loop', 'yes')
  end
end
)


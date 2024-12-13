local awful = require("awful")
local util = require("util")
local osd = require("widget.osd")
local default_profile = require("profiles.__default__")
local profile = default_profile.make_config()

local theme = require("themes.breeze_like")

local function insert_everything(outlist, inlist)
  for _, v in ipairs(inlist) do
    table.insert(outlist, v)
  end
end

table.insert(profile.autoreload,
  'xinput set-prop "USB OPTICAL MOUSE " "libinput Accel Profile Enabled" 0 1'
)

profile.theme = theme.settings_with {
  font = "Cousine Nerd Font 8",
  icon_theme = "Tela black dark",
  wallpaper = "marisa0",
}

insert_everything(profile.launcher, {
  util.make_launcher {
    mod = { profile.keys.ctrl, profile.keys.alt },
    key = "g",
    cmd = "flatpak run net.lutris.Lutris",
    description = "Launch lutris",
    group = "launcher",
  },
  util.make_launcher {
    mod = { profile.keys.ctrl, profile.keys.alt },
    key = "u",
    cmd = function()
      local script = default_profile.profile_path("script/toggle_screen.sh")
      util.call_cmd(script, function(stdout, _)
        osd.text({
          screen = awful.screen.focused(),
          text = stdout,
          icon = profile.theme.volume_high,
        })
      end)
    end,
    description = "toggle crt",
    group = "script",
  }
})


return profile

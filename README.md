# bbwin

##Description
installs the bbwin monitoring agent (https://sourceforge.net/p/bbwin/wiki/Home/) to monitor windows servers with Xymon.

##Requirements
Tested on Windows 2008R2 and Windows 2012R2

##Recipes
###default
Installs the Xymon package (v 0.13) with all defaults.  
### attributes
To install an older version, you can override ```node['bbwin']['version'] and node['bbwin']['source_url']```

##lwrps
###bbwin_setting
Changes a setting in the bbwin.cfg config file. This resource will add the setting if it does not exist, and will
add any options that dont already exist.  If the section to which it is being added does not exist it will 
be created as well.  Any setting not specified will remain unchanged. You may want to use a template for the config
file if you have many settings that need to be changed.  Its probably not a good idea to use both a template for the 
bbwin.cfg as well as this resource, however, as they will probably conflict.

####actions
* :set (default) - sets the seting to the value and options specified, or creates the setting if it does not exist

####attributes

| Name | Type | Description | 
|------|------|-------------|
| name | String | The name of the setting (name attribute of the setting node in the xml config file) |
| section | String | the configuraiton section ( the parent node in the xml file - eg bbwin cpu disk externals memory msgs procs svcs uptime) |
| value | String | the "value' attribute of the setting node in the config file |
| options | Hash | A hash of other attributes to add to the setting node (warnlevel, paniclevel, etc) |
| config_file_path | String| path to the config file.   default: "#{ENV['SYSTEMDRIVE']}\\Program Files (x86)\\BBWin\\etc\\BBWin.cfg" |

#### example
```ruby
bbwin_setting 'bbdisplay' do
  section 'bbwin'
  value '127.0.0.1'
  notifies :restart, 'service[bbwin]'
end

service 'bbwin' do
  action :nothing
end
```

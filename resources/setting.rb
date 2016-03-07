actions :set
default_action :set

attribute 'name', :name_attribute => true, :kind_of => String, :required => true
attribute 'section', kind_of: String, required: true, equal_to: %w(bbwin cpu disk externals memory msgs procs svcs uptime)
attribute 'value', :kind_of => String
attribute 'options', :kind_of => Hash
attribute 'config_file_path', default: "#{ENV['SYSTEMDRIVE']}\\Program Files (x86)\\BBWin\\etc\\BBWin.cfg"

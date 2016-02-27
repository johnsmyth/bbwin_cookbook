actions :create
default_action :create

attribute 'name', name_attribute: true, kind_of: String, required: true
attribute 'template', kind_of: String
attribute 'cookbook', kind_of: String
attribute 'variables', kind_of: Hash

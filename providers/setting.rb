#include Chef::Mixin::ShellOut

def whyrun_supported?
  true
end

use_inline_resources

action :set do
  write_setting(new_resource.config_file_path, new_resource.section, new_resource.name, new_resource.value, new_resource.options) 
end

private 

def load_current_resource
  chef_gem 'nokogiri' do 
    action :install
  end

  require 'nokogiri'
 
end


def write_setting(cfg_file, section, setting_name, value, options)
  options = {} unless options
  options['value'] = value

  config_doc = load_doc(cfg_file)

  setting_node = get_setting(config_doc, section, setting_name)
  setting_node = create_setting_node(config_doc, section, setting_name) unless setting_node

  change_setting(setting_node, section, setting_name, options)

  write_doc(cfg_file, config_doc)
end

def load_doc(cfg_file)
  ::File.open(cfg_file) { |f| Nokogiri::XML(f) }
end

def write_doc(cfg_file, config_doc)
  ::File.write(cfg_file, config_doc.to_xml)
end

def change_setting (setting_node, section, setting_name, options)
  if setting_node
    options.each do |option_name, option_value|
      if setting_node[option_name] != option_value 
        converge_by "BBWin config: Changed #{setting_name} in section #{section} - value of #{option_name} changed from #{setting_node[option_name] } to #{option_value}" do
          setting_node[option_name] = option_value 
        end
      end
    end
  end
end

def create_setting_node(config_doc, section, setting_name)
  section_node = get_section(config_doc, section)
  section_node = create_section(config_doc, section) unless section_node

  new_node = section_node.add_child(Nokogiri::XML::Node.new "setting", config_doc)
  new_node['name'] = setting_name
  get_setting(config_doc, section, setting_name)
end

def get_setting(xml_doc, section, setting_name)
  xml_doc.xpath("//#{section}/setting[@name = \"#{setting_name}\"]")[0]
end


def get_section(xml_doc, section)
  xml_doc.xpath("//#{section}")[0]
end

def create_section(xml_doc, section)
  config_node = xml_doc.xpath('/configuration')[0]
  config_node.add_child(Nokogiri::XML::Node.new section, config_node)
  get_section(xml_doc, section)
end

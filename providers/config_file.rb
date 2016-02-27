def whyrun_supported?
  true
end

use_inline_resources

action :create do
  template new_resource.name do
    source new_resource.template
    cookbook new_resource.cookbook if new_resource.cookbook
    variables(new_resource.variables)
  end
end

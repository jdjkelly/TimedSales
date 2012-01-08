module TabsHelper
  # Create a tab as <dd> and give it the id "current" if the current action matches that tab
  def tab(name, url, options = {})
    if controller.action_name =~ (options[:highlight] = /#{name}/i)  && controller.controller_name == url[:controller]
      content_tag :dd, link_to(options[:label] || name.to_s.capitalize, url, {:id => "current"})
    else
      content_tag :dd, link_to(options[:label] || name.to_s.capitalize, url)
    end    
  end
end
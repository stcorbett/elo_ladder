# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def error_messages(model, attribute)
    model.errors.on(attribute).map{|error| %%<br/><span class="form-error">#{error}</span>%} unless model.errors.on(attribute).blank?
  end
  
  def nav_link(link, target, params, active_params)
    active = true
    active_params.each_pair{ |k,v| active = false unless params[k] == v }
    "<li#{%% class='active'% if active}>#{link_to link, target}</li>"
  end

end

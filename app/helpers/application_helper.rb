module ApplicationHelper
  
  def nav_link(link, target, active_params)
    active = true
    active_params.each_pair{ |k,v| active = false unless params[k] == v }
    "<li#{%% class='active'% if active}>#{link_to link, target}</li>"
  end
  
  def block_to_partial(partial_name, options = {}, &block)
    options.merge!(:body => capture(&block))
    concat(render(:partial => partial_name, :locals => options))
  end

  def single_column(options = {}, &block)
    block_to_partial('shared/single_column', options, &block)
  end 

  def left_column(options = {}, &block)
    block_to_partial('shared/left_column', options, &block)
  end
  
  def right_column(options = {}, &block)
    block_to_partial('shared/right_column', options, &block)
  end
  
end

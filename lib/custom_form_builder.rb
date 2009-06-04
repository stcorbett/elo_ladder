class CustomFormBuilder < ActionView::Helpers::FormBuilder
  
  def label(method, text = nil, options = {})
    text = text || method.to_s.humanize
    
    unless @object.nil? || options[:hide_errors]
      errors = @object.errors.on(method.to_sym)
      errors = [errors].compact unless errors.is_a?(Array)
      text += " #{errors.first}" unless errors.empty?
    end
 
    text += options[:additional_text].to_s
 
    super(method, text, options)
  end
  
  def input(method, attribute, text = nil, options = {})
    if method == :check_box
      "<p>\n  #{send(method, attribute, options)}\n  #{label(attribute, text)}\n</p>"
    else
      "<p>\n  #{label(attribute, text)}\n  <br/>\n  #{send(method, attribute, options)}\n</p>"
    end
  end
  
end

module ActionView
  module Helpers
    module FormTagHelper
      
      def buttons(buttons)
        output = "<div class='buttons'>\n"

        buttons.each do |button|
          text =    button.is_a?(Array) ? button[0] : button
          options = button.is_a?(Array) ? button[1] : {}
          options[:type] ||= :positive if text.downcase =~ /submit|save|send|add|create|update/
          options[:type] ||= :negative if text.downcase =~ /cancel|delete/
        
          output << (options.include?(:link_to) ? "  #{render_button_link(text, options)}" : "  #{render_button(text, options)}")
        end

        output << "</div>\n"
        output << "<p class='clear'></p>"
      end
      
      def button(text, options = {})
        buttons([[text, options]])
      end
      
      
      private
      
      def render_button(text, options = {})
        type = options.delete(:type)
        
        case type
        when :positive
          "<button type='submit' class='positive'><img src='/images/#{ options[:icon] || 'icons/tick.png' }' alt=''/>#{text}</button>\n"
        when :negative
          "<button type='submit' class='negative'><img src='/images/#{ options[:icon] || 'icons/cross.png' }' alt=''/>#{text}</button>\n"
        else
          "<button type='submit'>#{image_tag('/images/' + options[:icon]) unless options[:icon].blank?}#{text}</button>\n"
        end
      end
      
      def render_button_link(text, options = {})
        type = options.delete(:type)
        link = options.delete(:link_to)
        
        case type
        when :positive
          (link_to "#{image_tag((options[:icon] || 'icons/tick.png'), :alt => '')}#{text}", link, options.merge(:class => 'positive')) + "\n"
        when :negative
          (link_to "#{image_tag((options[:icon] || 'icons/cross.png'), :alt => '')}#{text}", link, options.merge(:class => 'negative')) + "\n"
        else
          text = (image_tag('/images/' + options[:icon]) + text) unless options[:icon].blank?
          (link_to text, link, options) + "\n"
        end
      end
      
    end
  end
end
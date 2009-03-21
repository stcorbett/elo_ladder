class CustomFormBuilder < ActionView::Helpers::FormBuilder
  
  # adds error message directly inline to a form label
  # accepts all the options normall passed to form.label as well as:
  # :hide_errors - true if you don't want errors displayed on this label
  # :additional_text - Will add additional text after the error message or after the label if no errors
  def label(method, text = nil, options = {})
    text = text || method.to_s.humanize
    unless @object.nil? || options[:hide_errors]
      errors = @object.errors.on(method.to_sym)
      errors = [errors].compact unless errors.is_a?(Array)
      text += errors.map{|a| "<br/><span class=\"form-error\">#{a}</span>" }.join
    end
 
    text += options[:additional_text].to_s
 
    super(method, text, options)
  end
  
end
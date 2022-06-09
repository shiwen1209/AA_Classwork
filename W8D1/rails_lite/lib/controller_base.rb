require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res)
    @req = req
    @res = res
    @already_built_response = nil
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    !@already_built_response.nil? 
  end

  # Set the response status code and header
  def redirect_to(url)
    if already_built_response?
      raise "double render error"
    else
      @already_built_response = "redirect"
    end
    @res.status = 302 
    @res.location = url
    return nil
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    if already_built_response?
      raise "double render error"
    else
      @already_built_response = "render"
    end 
    @res.write(content)
    @res['Content-Type'] = content_type
    return nil 
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  require 'active_support/inflector'
  def render(template_name)
    class_name = self.class.to_s.underscore
    temp_path = File.join('views', class_name, "#{template_name}.html.erb")
    path = File.read(temp_path)
    content = ERB.new(path).result(binding)
    # content = File.dirname(temp_content.to_s)
    render_content(content ,'text/html')
  end

  # method exposing a `Session` object
  def session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end
end


require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = route_params.merge(req.params)  #what are the params in req?
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
    session.store_session(@res)
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
    session.store_session(@res)
    return nil 
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  require 'active_support/inflector'
  def render(template_name)
    class_name = self.class.to_s.underscore
    temp_path = File.join('views', class_name, "#{template_name}.html.erb")
    content = File.read(temp_path)
    erb_content = ERB.new(content).result(binding)
    
    render_content(erb_content ,'text/html')
   
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    self.send(name)
    if !already_built_response?
      render(name)
    end

  end
end


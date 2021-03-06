require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    if req.cookies['_rails_lite_app']
      @cookie_var = JSON.parse(req.cookies['_rails_lite_app'])
    else
      @cookie_var = {}
    end
  end

  def [](key)
    @cookie_var[key]
  end

  def []=(key, val)
    @cookie_var[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
      res.set_cookie('_rails_lite_app', {path: "/", value: @cookie_var.to_json})
  end
end

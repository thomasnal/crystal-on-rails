class Router
  getter :routes
  getter :controllers

  # This macro is a hack that allows to instansiate controllers through 
  # @controllers.fetch("ControllerName")
  macro register_controller(klass_name)
    @controllers[{{klass_name}}.to_s] = {{klass_name.id}}
  end

  def initialize()
    @routes      = [] of Dispatch::Route
    @controllers = {} of String => Base::Controller.class 
    @methods     = {} of String => Symbol
  end

  # Adds controller to hash @controllers and make it available for app
  def register(controller)
    register_controller controller
  end 

  # It allows to 'draw' routes like you can do in Rails routes.rb
  def draw(&block)
    with self yield
  end

  # Sets a route that should respond to GET HTTP method
  # The synopsis of arguments receive is Rails-like:
  # get "/products/:id", "products#show"
  # where 'products' is a controller named ProductsController, and "show" is it's action
  def get(pattern, controller_action)
    pattern.gsub(/\$/, "\$") unless pattern == "/"
    controller, action = controller_action.split("#")
    controller = controller.capitalize+"Controller"
    @routes << Dispatch::Route.new(pattern, controller, action)
  end

  # Actually, performs a routing 
  def call(request : Http::Request)
    path     = request.path
    response = Http::Response.new(404, "Not found")
    @routes.each do |route|
      if route.matches?(path)
        response = Http::Response.new(200, "#{path} of application")
        controller = route.controller.capitalize+"Controller"
        controller_instance = @controllers[controller].new(request, response)
        response = controller_instance.call_action(route.action)
        break
      end
    end
    return response
  end
end

# TODO: Fix call issues with instantiating controller
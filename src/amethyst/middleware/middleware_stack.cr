class MiddlewareStack

  include Sugar
  singleton_INSTANCE
  include Enumerable(Class)
  
  def initialize()
    @middlewares   = [] of Middleware::Base.class
  end

  def build_middleware
    print "Building middleware\n"
    app = Dispatch::Router::INSTANCE
    @middlewares.reverse.each do |mdware|
      mdware = instantiate mdware
      app = mdware.build(app)
    end
    puts self
    app
  end

  def use(middleware)
    @middlewares << middleware
  end

  def each
    0.upto(@middlewares.length-1) do |i|
      yield @middlewares[i]
    end
  end

  def to_s(io : IO)
    msg = "\n"
    @middlewares.each do |mdware|
      msg += "use #{mdware}\n"
    end
    io << msg
  end 
end

# TODO: Implement insert_before, delete, etc.
require "../spec_helper"

class ViewController < Controller
  actions :index, :hello, :redirect

  getter name : String = ""

  def index
    html "Hello world!<img src='/assets/amethyst.jpg'>"
  end

  view "hello", "#{__DIR__}/views/"
  def hello
    @name = "Andrew"
    respond_to do |format|
      format.html { render "hello" }
    end
  end

  def redirect
    respond_to do |format|
      format.html { redirect_to "user/45" }
    end
  end
end

module My
  module Inner
    class App < Amethyst::Base::App
    end
  end
end

class GlobalApp < Amethyst::Base::App
end

# Crystal on Rails

[![Build Status](https://travis-ci.org/thomasnal/crystal-on-rails.svg)](https://travis-ci.org/thomasnal/crystal-on-rails)

Crystal on Rails (CoR) is a web-application framework for [Crystal](https://github.com/manastech/crystal) language. Crystal on Rails aspires to move the forked project foward and implement more features that allow convenient way of building web applications the way Ruby on Rails does. Ultimately it will include all needed to create database-backed web applications in a fast and conveninet way while benefiting from fast performance of a compiled language.

### Changelog

* Updated to Crystal 0.21.0. Fixed to make the tests pass. Enjoy everybody!
* Forked Amethyst. Renamed to Crystal on Rails.
  - Inherited a broken project failing to compile including failed compilation of tests.

**Latest version** - [0.1.7](https://github.com/Codcore/Amethyst/releases/tag/v0.1.7)

Note that Amethyst is in its early stage, so it lacks for whole bunch of things. You can give a hand with contributing.
* [Roadmap](https://github.com/Codcore/Amethyst/wiki/Roadmap)

[Amethyst examples](https://github.com/Codcore/amethyst-examples)

For detailed information, see docs on our [wiki](https://github.com/Codcore/Amethyst/wiki) below:

* [Installation](https://github.com/Codcore/Amethyst/wiki/Installation)
* [Usage](https://github.com/Codcore/Amethyst/wiki/Usage)
* [Controllers](https://github.com/Codcore/Amethyst/wiki/Controllers)
* [Routing](https://github.com/Codcore/Amethyst/wiki/Routing)
* [Middleware](https://github.com/Codcore/Amethyst/wiki/Middleware)
* [Static files](https://github.com/Codcore/Amethyst/wiki/StaticFiles)
* [Applications](https://github.com/Codcore/Amethyst/wiki/Applications)


[Here are some benchmarking results](https://gist.github.com/Codcore/0c7a331b69eed542fb78)

For now, next things are implemented:
* class-based controllers with method-based actions
* views for actions (*.ecr)
* filters for action
* middleware support
* simple REST routing
* default routes for controller
* path, GET and POST params inside actions
* basic cookies support
* static files serving
* http logger and timer for developers
* simple environments support
* simple session support

## Example
Here is classic 'Hello World' in Amethyst
```crystal
require "amethyst"

class WorldController < Base::Controller
  actions :hello

  view "hello", "#{__DIR__}/views"
  def hello
    @name = "World"
    respond_to do |format|
      format.html { render "hello" }
    end
  end
end

class HelloWorldApp < Base::App
  routes.draw do
    all "/",      "world#hello"
    get "/hello", "world#hello"
    register WorldController
  end
end

app = HelloWorldApp.new
app.serve

# /views/hello.ecr
Hello, <%= name %>
```

## Using amethyst-bin to quickly generate your application

[amethyst-bin](https://github.com/Sdogruyol/amethyst-bin) is an executable shell script to help you
quickly generate your Amethyst application.

It handles installing the base dependencies, views / controllers folder generation and main application file generation.

```
curl https://raw.githubusercontent.com/Sdogruyol/amethyst-bin/master/amethyst > amethyst && chmod +x amethyst
./amethyst sample
```

Voila! Your app is ready now you can run it

```cd sample && crystal run src/sample.cr```

## Development

Feel free to fork project and make pull-requests.


## Contributing

I would be glad for any help with contributing.

1. Fork it ( https://github.com/Codcore/amethyst/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request


## Contributors

- [Andrew Yaroshuk](https://github.com/Codcore) Codcore - creator, maintainer

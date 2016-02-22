# Janrain

**A small library to assist with AuthN/AuthZ provided by Janrain.**  
[https://github.com/rickr/janrain](https://github.com/rickr/janrain)


## Installation

  1. Add janrain to your list of dependencies in `mix.exs`:

        def deps do
          [{:janrain, "~> 0.0.1"}]
        end

  2. Ensure janrain is started before your application:

        def application do
          [applications: [:janrain]]
        end

## Usage

This guide is written with the assumption you're using [Guardian](https://github.com/ueberauth/guardian) and [Phoenix](http://www.phoenixframework.org).

* Sign up for a Janrain account [here](https://janrain.com).
* Create your app and a widget for that app.
* To use the widget paste the javascript into any page you wish to log in from. Make sure you update the ```janrain.settings.tokenUrl``` variable. 
* Create a route for Janrain to post back to (this is the value of the ```janrain.settings.tockenUrl``` from the step above).
* In this function all ```Janrain.authenticate_user_with($TOKEN)``` with the token that's posted to you. This will either return {:failed} or the signed in User's profile data. You can now store this data locally. ``` %{"profile" => %{"identifier"]}}``` is unique to each user and can be used as their primary key.
# ActiveYaml

A simple key/value storage built on top of YAML::Store with an ActiveRecord like interface

## Installation

Add this line to your application's Gemfile:

    gem 'active_yaml'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_yaml

## Usage

For now, it uses a "db" directory to store the YAML files, so create it first.

Then just include it in your model classes

    ```ruby
    class Post
      include ActiveYaml

      attr_accessor :title, :body
    end
    ```

And use it like you use ActiveRecord

    ```ruby
    p = Post.new
    p.title = "Great post!"
    p.body = "Lorem ipsum..."
    p.save

    Post.all # => [#<Post:0x895bb38 @title="Great post!", @body="Lorem ipsum...", @id=1>]

    Post.find(1) # => #<Post:0x954bc69 @title="Great post!", @body="Lorem ipsum...", @id=1>
    ```

You can use "where" to make "queries" on more than one attribute:

    ```ruby
    Post.where(author: 'Brunno', visibility: 'public')
    # => [#<Post:0x895bb38 @author="Brunno", @visibility="public", @id=1>, #<Post:0x457pa36 @author="Brunno", @visibility="public", @id=2>]
    ```

## Why?

Right now I'm in the middle of some "reinventing the wheels using standard library" thing and this was a really obvious one.

But it is actually useful for projects that don't deal with problems like concurrency, overload etc and for those who like to access the data a lot (it's really handy when it's in .yml files).

So what I mean with this is, please don't use it to build the next Twitter and then bitch about Ruby.

## TODO

1. Add tests (ha!)
2. Mirror more methods from ActiveRecord::Base
3. Maybe try to instantiate relationship objects automagically based on id.
4. You tell me.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

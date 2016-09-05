# MosaicoRails
It's an Rails backend for [Mosaico](https://github.com/voidlabs/mosaico)

## Getting started

RailsMosaico 1.0 works the gem [Paperclip](https://github.com/thoughtbot/paperclip).

You can add it to your Gemfile with:

```ruby
gem 'mosaico-rails'
```

Run the bundle command to install it, or install it yourself as:
```bash
$ gem install mosaico-rails
```

Next, you need to run the generator:

```console
$ rails generate mosaico_rails:install
```

# Setup

Run the following command for an easy one-step installation:
```bash
  rails generate mosaico_rails:install [OWNER_CLASS] [GALLERY_CLASS] [IMAGE_CLASS]
```
When you run the command install without argument, the first one will be `User`, next `Gallery` and then `Image`. Here, `User`, corresponds to the owner's gallery. You must write all class name if you want to change the last one. 



## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

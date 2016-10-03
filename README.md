# MosaicoRails
It's an Rails backend for [Mosaico](https://github.com/voidlabs/mosaico)

## Getting started

RailsMosaico 1.0 works the gem [Paperclip](https://github.com/thoughtbot/paperclip).

You can add it to your Gemfile with:

```ruby
gem 'mosaico-rails'
```

# Setup

Run the following command for an easy one-step installation:
```bash
  rails generate mosaico_rails:install OWNER_CLASS
```
This command generates `MosaicoRails::Gallery` and `MosaicoRails::Image` migrations. You can bind your Gallery to an existing model as User or whatever as:
```bash
  rails generate mosaico_rails:install User
```
It generates some routes, mount as `'/'`... bla bla les routes

Then,
```bash
  rake db:migrate
```

# Storage
As [Paperclip](https://github.com/thoughtbot/paperclip), you can store your file into your file system or to S3. Actually `mosaico-rails` doesn't provide `Fog` storage adapter.

# Note
You should check your version of uglifier, if needed, as you can experience problems while uglifying mosaico's source code that is already uglified. We recommand using `uglifier >= (3.0.2)`

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# APICraft Rails
🚀 Accelerates your development by 2-3x with an API Design First approach. Seamlessly integrates with your Rails application server — no fancy tooling or expenses required.

![APICraft Rails Logo](assets/apicraft_rails.png)

## ✨ Features
- 🗂 **Simplified Files Management** - Management of `openapi` specifications from within `app/contracts` directory.

- 🧑‍💻️ **Dynamic Mock Data Generation** - Detects the specifications and instantly mounts working routes with mock responses. No extra configuration required.

- ⚙️ **Customizable Mock Responses** - Tailor mock responses to simulate different scenarios and edge cases, helping your team prepare for real-world conditions right from the start.

- 🔍 **Enhanced API Validation** - Validate API Requests based on the specifications. Easy configurable to turn it on or off.

- 📺 **Documentation Out of the Box** - Documentation is available at `/apicraft` using `SwaggerDoc` and `Redoc` both with "Try it out" feature.


## 🪄 Works Like Magic

Once you’ve installed the gem, getting started is a breeze. Simply create your OpenAPI contracts within the `app/contracts` directory of your Rails application. You’re free to organize this directory in a way that aligns with your project's standards and preferences. That’s it—your APIs will be up and running with mock responses, ready for development without any additional setup. It's as effortless as it sounds!

## 🕊 API Design First Philosophy

![APICraft Rails Logo](assets/api_first_workflow.jpg)

The API Design First philosophy is at the heart of APICraft Rails, and it’s a game-changer for development speed and efficiency:

- 🔄 **Parallel Development:** By designing your APIs upfront, both frontend and backend teams can work simultaneously using mock APIs, eliminating bottlenecks and reducing wait times.

- 📜 **Clear Contracts:** OpenAPI contracts serve as a single source of truth, ensuring that all teams are aligned on how the API should behave, reducing misunderstandings and rework.

- ⚙️ **Early Testing:** Mock APIs allow QA to begin testing earlier in the development cycle, catching issues before they become costly to fix.

- 🔍 **Faster Feedback Loop:** Immediate feedback on API design helps you iterate quickly, refining your API based on real usage scenarios, ultimately leading to a more robust product.

- 🚀 **Reduced Integration Time:** With consistent API contracts in place, integrating various components becomes smoother and faster, cutting down on the time required to bring everything together.

By adopting an API Design First approach with APICraft Rails, you can accelerate your development process by 2-3x, delivering high-quality APIs faster and with fewer headaches.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apicraft'
```

And then execute:

    $ bundle install

After the installation in your rails project, you can start adding contracts in the `app/contracts` directory. This can have any internal directory structure based on your API versions, standards, etc.

Add the APICraft Middleware into your Rails application, via the `config/application.rb`

```ruby
# config/application.rb
module App
  class Application < Rails::Application
    # Rest of the configuration
    config.middleware.use Apicraft::Middleware
  end
end
```

```ruby
# config/routes.rb
# frozen_string_literal: true

Rails.application.routes.draw do
  # Rest of the routes
  mount Apicraft::Web::App, at: "/apicraft"
end
```

Now every API in the specification has a functional version. If a path isn't implemented, APICraft serves a mock response; otherwise, it forwards the request to your application as usual.

## Usage

Add your specification files to the `app/contracts` directory in your Rails project. You can also configure this directory to be something else.
```
my_rails_app/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb
│   │   └── users_controller.rb
│   ├── contracts/
│   │   ├── users_contract.yaml
│   │   └── orders_contract.yaml
│   ├── models/
│   │   ├── user.rb
│   │   └── order.rb
```
### 🥷 Working with Mock APIs
**APICraft** dynamically generates mock APIs by interpreting contract specifications on the fly. If a real implementation is available, it seamlessly forwards the request to it.

`https://yoursite.com/api/orders`
```json
[
  {
    id: 66,
    name: "tempora",
    description: "error"
  },
  {
    id: 41,
    name: "et",
    description: "id"
  }
]
```

### 👀 API Introspection
All APIs are can be introspected at `https://yoursite.com/apicraft/*`. You need to append the API path that you are looking for.

Example: `https://yoursite.com/apicraft/api/orders`
```json
{
  summary: "Retrieve a list of orders",
  description: "Returns a list of orders in either JSON or XML format.",
  operationId: "getOrders",
  parameters: [
    {
      name: "format",
      in: "query",
      description: "The response format (json or xml)",
      required: false,
      schema: {
      type: "string",
      enum: [
        "json",
        "xml"
      ]
    }
  },
  responses: {
    ...
  }
],
```
### 👀 API Documentation

You can browse API Documentation at
- https://yoursite.com/apicraft/swaggerdoc
- https://yoursite.com/apicraft/redoc

## Configuration


## Development


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/apicraft. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/apicraft/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Apicraft project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/apicraft/blob/main/CODE_OF_CONDUCT.md).

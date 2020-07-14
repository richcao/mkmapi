# Mkmapi

Ruby interface to the cardmarket.eu

## Usage

You'll need an OAuth credentials for a dedicated app from Mkmapi.

**Add to your Gemfile**

    gem 'mkmapi'

**Create a session**

    session = Mkmapi.auth({
      consumer_key: "xxxx",
      consumer_secret: "xxxx",
      token: "xxxx",
      token_secret: "xxxx",
    })

**Retrieve your account's data**

    me = session.account # => Mkmapi::Account
    me.id # => 1234
    me.username # => 'your_user_name'

## TODO

* Domain models
* Documentation
* Account Management
* Market Place Information (partially)
* Order Management
* Shopping Cart Manipulation
* Stock Management
* Wants List Management

## Contributing to Mkmapi

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.

## References
Cardmarket RESTful API Documentation: https://api.cardmarket.com/ws/documentation/API_2.0:Main_Page

## Contributors

[<img src="https://github.com/arjenbrandenburgh.png?size=72" alt="arjenbrandenburgh" width="72">](https://github.com/arjenbrandenburgh)
[<img src="https://github.com/knaveofdiamonds.png?size=72" alt="knaveofdiamonds" width="72">](https://github.com/knaveofdiamonds)

# Open Telekom Cloud SDK for Ruby
![Build Status](https://travis-ci.org/streetspotr/otc-sdk-ruby.svg?branch=master)

This is a small SDK which wraps the Open Telekom Cloud API. It currently supports only a limited amount of functionalities.

## Configuration

The only way to currently authenticate with this library is via a user token. To obtain a token the API requires several credentials.

- IAM username
- IAM password
- domainname (can be copied from the "My Credential" screen)
- project ID (can be copied from the "My Credential" screen)
- region of the project

```
Otc::Configuration.configure do |config|
  config.username = "testuser"
  config.password = "test1234"
  config.domainname = "OTC-EU-DE-001"
  config.project = "41234123"
  config.region = "eu-de"
end
```

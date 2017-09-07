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

## Auto Scaling

All available fields of `Otc::ASGroup` are available here: https://docs.otc.t-systems.com/en-us/api/as/en-us_topic_0043063030.html

### Querying

    Otc::ASGroup.query_all                           # get all auto scaling groups
    Otc::ASGroup.query_all(name: "my_scaling_group") # get all auto scaling groups filtered by the given name
    Otc::ASGroup.query_one                           # get the first auto scaling group
    Otc::ASGroup.query_one(name: "my_scaling_group") # get the first auto scaling group filtered by the given name
    

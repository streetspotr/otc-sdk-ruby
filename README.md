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

## General

All responses are wrapped by objects that hold their information via method accessors. Example:

    ecs = Otc::ECS.query_one
    ecs.name # => "cool-server"

Some information is cached for improved performance using memoization and is therefore not updated on subsequent calls.

## Auto Scaling

### Querying

    Otc::ASGroup.query_all                           # get all auto scaling groups
    Otc::ASGroup.query_all(name: "my_scaling_group") # get all auto scaling groups filtered by the given name
    Otc::ASGroup.query_one                           # get the first auto scaling group
    Otc::ASGroup.query_one(name: "my_scaling_group") # get the first auto scaling group filtered by the given name
    
    # convenience methods
    group = Otc::ASGroup.query_one(name: "my_scaling_group") # => #<Otc::ASGroup>
    group.instances                                          # get all instances of the auto scaling group

## EIP

### Querying

    Otc::EIP.query_all # get all EIPs

## ECS

### Querying

    Otc::ECS.query_all                    # get all ecs
    Otc::ECS.query_all(name: "my_server") # get all ecs filtered by the given name
    Otc::ECS.query_one                    # get the first ecs
    Otc::ECS.query_one(name: "my_server") # get the first ecs filtered by the given name
    
    # convenience methods
    ecs = Otc::ECS.query_one # => #<Otc::ECS>
    ecs.public_ip            # => "160.44.232.150"

## Known Issues

- The API uses a limit for nearly every API request but the SDK does not support limits at the moment, so most `query_all` methods won't return all results.
- Obtaining the public IP address of an ECS instance is rather cumbersome. There might be a better possibility than comparing the private IP of the ECS instance to the private IP of all EIPs.

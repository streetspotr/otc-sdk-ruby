require "net/http"
require "json"

module Otc
  class Request
    class UnauthorizedError < RuntimeError; end
    class ApiError < RuntimeError; end

    class << self
      def base_uri(service:, path:)
        "https://#{service}.#{Configuration.region!}.otc.t-systems.com#{path}"
      end

      # returns the token if it is still valid (not older than 20 hours)
      # else obtains a new token
      def token
        latest_timestamp = @_token ? @_token[:timestamp] : nil
        twenty_hours = 20 * 60 * 60

        if latest_timestamp.nil? || latest_timestamp < (Time.now - twenty_hours).to_i
          body = {
            auth: {
              identity: {
                methods: ["password"],
                password: {
                  user: {
                    name: Configuration.username!,
                    password: Configuration.password!,
                    domain: { name: Configuration.domainname! }
                  }
                }
              },
              scope: {
                project: { id: Configuration.project! }
              }
            }
          }

          response = post(service: "iam", path: "/v3/auth/tokens", body: body.to_json)

          @_token = {
            token: response.fetch("X-Subject-Token"),
            timestamp: Time.now.to_i
          }
        end

        @_token.fetch(:token)
      end

      def post(service:, path:, body:)
        uri = URI.parse(base_uri(service: service, path: path))
        req = Net::HTTP::Post.new(uri.request_uri, "Content-Type" => "application/json;charset=utf8")
        req.body = body
        send(req, uri)
      end

      def send(req, uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.request(req).tap do |response|
          raise UnauthorizedError, "could not authorize request" if response.code == "401"
          raise ApiError, "error during api call: #{response.body}" if response.code.to_i >= 300
        end
      end
    end
  end
end

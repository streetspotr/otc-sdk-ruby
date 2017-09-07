require "hashie"

module Otc
  class EIP < Hashie::Dash
    class << self
      def query_all
        response = Request.get service: "ecs", path: "/v1/#{Configuration.project!}/publicips"
        JSON.parse(response.body)["publicips"].map do |ip|
          EIP.new(ip)
        end
      end
    end

    [
      "id", "status", "type", "port_id", "public_ip_address", "private_ip_address",
      "tenant_id", "create_time", "bandwidth_id", "bandwidth_share_type", "bandwidth_size"
    ].each { |prop| property prop }
  end
end

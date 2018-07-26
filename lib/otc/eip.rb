require "hashie"

module Otc
  class EIP < Hashie::Mash
    class << self
      def query_all
        response = Request.get service: "ecs", path: "/v1/#{Configuration.project!}/publicips"
        JSON.parse(response.body)["publicips"].map do |ip|
          EIP.new(ip)
        end
      end
    end
  end
end

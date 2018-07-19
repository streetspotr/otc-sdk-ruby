require "hashie"

module Otc
  class ECS < Hashie::Mash
    class << self
      def query_all(name: nil)
        response = Request.get service: "ecs", path: "/v2/#{Configuration.project!}/servers/detail?name=#{name}"
        JSON.parse(response.body)["servers"].map do |server|
          ECS.new(server)
        end
      end

      def query_one(name: nil)
        query_all(name: name).first
      end
    end

    def public_ip
      @_public_ip ||= begin
        private_addresses = self.addresses.values.flatten.map { |val| val["addr"] }

        eip = EIP.query_all.select { |ip| private_addresses.include?(ip.private_ip_address) }.first
        if eip
          eip.public_ip_address
        end
      end
    end
  end
end

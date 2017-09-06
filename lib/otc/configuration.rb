module Otc
  class Configuration
    class << self
      attr_accessor :project, :username, :password, :region, :domainname

      def configure
        yield self
      end
    end
  end
end

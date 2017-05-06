require 'aws/bootstrap'
require 'aws/bootstrap/options'
require 'optparse'

module Aws
  module Bootstrap
    class CLI
      def self.run(argv)
        Aws::Bootstrap::Options.parse(argv)
      end
    end
  end
end

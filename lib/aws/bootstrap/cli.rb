require 'aws/bootstrap'
require 'aws/bootstrap/options'
require 'optparse'

module Aws
  module Bootstrap
    class CLI
      def self.start(argv)
        opts = Aws::Bootstrap::Options.parse(argv)
        execute(opts)
      end

      def self.execute(opts)
        if opts.fetch(:profile, nil)
          c = Aws::Bootstrap::RDS.new(opts)
          resp = c.create_rds_instance_with_profile
          puts "Your AWS account is creating #{resp.db_instance.db_instance_identifier} now!!"
        else
          puts "Please define profile with --profile option"
          exit 1
        end
      end
    end
  end
end

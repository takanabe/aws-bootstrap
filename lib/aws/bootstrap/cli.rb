require 'aws/bootstrap'
require 'optparse'

module Aws
  module Bootstrap
    class CLI
      def self.start(argv)
        opts = {}
        ARGV.options do |opt|
          begin
            opt.on('-p', '--profile PROFILE_NAME')     {|v| opts[:profile]          = v             }
            opt.on('-r', '--region REGION_NAME')       {|v| opts[:region]           = v             }
            opt.on('-s', '--service AWS_SERVICE_NAME') {|v| opts[:service]          = v             }
            opt.parse!

            if opts.fetch(:service, nil) == 'rds'
              if opts.fetch(:profile, nil)
                c = Aws::Bootstrap::RDS.new(opts[:profile])
                resp =  c.create_rds_instance_with_profile
                puts resp
              else
                puts "define profile with --profile option"
                exit 1
              end
            else
              puts "define service type with --service option"
              exit 1
            end
          rescue => e
            $stderr.puts e
            exit 1
          end
        end
      end
    end
  end
end

require 'optparse'

module Aws
  module Bootstrap
    class Options
      def self.parse(argv)
        begin
          opts = {}
          sub_cmd_parsers = create_sub_cmd_parsers(opts)
          opts[:command] = argv.shift
          sub_cmd_parsers[opts[:command]].parse! argv
          if opts.fetch(:profile, nil)
            c = Aws::Bootstrap::RDS.new(opts)
            c.create_rds_instance_with_profile
          else
            puts "Please define profile with --profile option"
            exit 1
          end
        rescue => e
          $stderr.puts e
          exit 1
        end
      end

      def self.create_sub_cmd_parsers(opts)
        sub_cmd_parsers = Hash.new do |k,v|
          raise ArgumentError, "'#{v}' is not sub command"
        end

        sub_cmd_parsers['rds'] = OptionParser.new do |opt|
            opt.on('-p', '--profile PROFILE_NAME')                {|v| opts[:profile]              = v             }
            opt.on('-r', '--region REGION_NAME')                  {|v| opts[:region]               = v             }
            opt.on('--allocated_storage STORAGE_SPACE_GIGABYTE')  {|v| opts[:allocated_storage]    = v             }
            opt.on('--instance_type INSTANCE_TYPE')               {|v| opts[:instance_type]        = v             }
            opt.on('--name DB_INSTANCE_NAME')                     {|v| opts[:name]                 = v             }
            opt.on('--engine DB_ENGINE')                          {|v| opts[:engine]               = v             }
            opt.on('--master_user_password MASTER_PASSWORD')      {|v| opts[:master_user_password] = v             }
            opt.on('--master_user MASTER_USER')                   {|v| opts[:master_user]          = v             }
        end

        sub_cmd_parsers
      end
    end
  end
end

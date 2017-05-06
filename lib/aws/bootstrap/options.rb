require 'optparse'

module Aws
  module Bootstrap
    class Options
      def self.parse!(argv)
        begin
          opts = {}
          sub_cmd_parser = create_sub_cmd_parser(opts)
          opts[:command] = argv.shift
          sub_cmd_parser[opts[:command]].parse! argv
          opts
        rescue => e
          $stderr.puts e
          exit 1
        end
      end

      def self.create_sub_cmd_parser(opts)
        sub_cmd_parser = Hash.new do |k,v|
          raise ArgumentError, "'#{v}' is not sub command"
        end

        # profile: 'dev',
        # region: 'us-east-1',
        # allocated_storage: 5,
        # db_instance_class: "db.t2.micro",
        # db_instance_identifier: "test-rds",
        # engine: "MySQL",
        # master_user_password: "testtest",
        # master_username: "root",
        sub_cmd_parser['rds'] = OptionParser.new do |opt|
            opt.on('-p', '--profile PROFILE_NAME')                {|v| opts[:profile]              = v             }
            opt.on('-r', '--region REGION_NAME')                  {|v| opts[:region]               = v             }
            opt.on('--allocated_storage STORAGE_SPACE_GIGABYTE')  {|v| opts[:allocated_storage]    = v             }
            opt.on('--instance_type INSTANCE_TYPE')               {|v| opts[:db_instance_class]    = v             }
            opt.on('--name DB_INSTANCE_ID')                       {|v| opts[:db_instance_identifier]       = v     }
            opt.on('--engine DB_ENGINE')                          {|v| opts[:engine]               = v             }
            opt.on('--master_user_password MASTER_PASSWORD')      {|v| opts[:master_user_password] = v             }
            opt.on('--master_user MASTER_USER')                   {|v| opts[:master_username]      = v             }
            opt.on('--db_name DB_NAME')                           {|v| opts[:db_name]              = v             }
            opt.on('--availability_zone AZ')                      {|v| opts[:availability_zone]    = v             }
            opt.on('--publicly_accessible true/false')            {|v| opts[:publicly_accessible]  = v             }
            opt.on('--multi_az true/false')                       {|v| opts[:multi_az]             = v             }
            opt.on('--preferred_maintenance_window ' \
                                        'dd:hh24:mi-ddd:hh24:mi') {|v| opts[:preferred_maintenance_window] = v     }
            opt.on('--db_parameter_group_name PG_NAME')           {|v| opts[:db_parameter_group_name]      = v     }
            opt.on('--backup_retention_period NUM_DAYS')          {|v| opts[:backup_retention_period]      = v     }
            opt.on('--preferred_backup_window hh24:mi-hh24:mi')   {|v| opts[:preferred_backup_window]      = v     }
            opt.on('--tags TAGS')                                 {|v| opts[:tags]                 = v             }
            opt.on('--db_security_groups SG')                     {|v| opts[:db_security_groups]           = v     }
            opt.on('--db_subnet_group_name Subnet_Group')         {|v| opts[:db_subnet_group_name]         = v     }
            opt.on('--engine_version ENGINE_VERSION')             {|v| opts[:engine_version]               = v     }
            opt.on('--auto_minor_version_upgrade'\
                                         ' AUTO_MINOR_VERSIONUP') {|v| opts[:auto_minor_version_upgrade]   = v     }
            opt.on('--license_model LICENSE_MODEL')               {|v| opts[:license_model]        = v             }
            opt.on('--option_group_name OPTION_GROUP')            {|v| opts[:option_group_name]    = v             }
            opt.on('--storage_type STORAGE_TYPE')                 {|v| opts[:storage_type]         = v             }
            opt.on('--promotion_tier PROMOTION_TIER')             {|v| opts[:promotion_tier]       = v             }
            opt.on('--vpc_security_group_ids VPC_SG_IDS')         {|v| opts[:vpc_security_group_ids]       = v     }
        end

        sub_cmd_parser
      end
    end
  end
end

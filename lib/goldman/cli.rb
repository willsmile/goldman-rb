# frozen_string_literal: true

require "optparse"

module Goldman
  class Cli
    NON_OPERATIONAL_OPTS = [:config]

    def initialize(argv)
      @options = parse_argv(argv)
    end

    def run
      @options.each do |k, v|
        case k
        when :generate
          cmd_generate
        when *NON_OPERATIONAL_OPTS
          # Do nothing here
        when :version
          cmd_version
        end
      end
    end

    def cmd_generate
      dates = Goldman::DateRange.new(
        start_date_str: @options[:start_date],
        end_date_str: @options[:end_date],
        day_str: @options[:day],
        week_str: @options[:week]
      ).to_a
      config = Goldman::Config.new(path: @options[:config])
      formatter = Goldman::Formatter.new(customized: config.format)
      list = Goldman::ScheduleList.new(
        data: config.data,
        dates: dates
      ).generate

      Goldman::Presenter.print_schedule_list(
        list: list,
        formatter: formatter
      )
    end

    def cmd_version
      Goldman.version
    end

    private

    def parse_argv(argv)
      # default value
      options = {
        config: ENV["GOLDMAN_RB_PATH"] || File.expand_path("~/.goldman/config.yml")
      }

      OptionParser.new do |opts|
        opts.on("-c", "--config FILE", "Use a config file") { |v| options[:config] = v }
        opts.on("-g", "--generate", "Generate list of schedule options") { |v| options[:generate] = v }
        opts.on("-s", "--start [DATE]", "Set start date") { |v| options[:start_date] = v }
        opts.on("-e", "--end [DATE]", "Set end date") { |v| options[:end_date] = v }
        opts.on("-d", "--day [INTEGER]", "Set day interval from start date") { |v| options[:day] = v }
        opts.on("-w", "--week [INTEGER]", "Set week interval  from start date") { |v| options[:week] = v }
        opts.on("-v", "--version", "Show tool version") { |v| options[:version] = v }
        opts.parse!(argv)
      end

      return options
    end
  end
end

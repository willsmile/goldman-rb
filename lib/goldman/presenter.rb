# frozen_string_literal: true

require "date"

module Goldman
  class Presenter
    class << self
      def print_schedule_list(list:, formatter:)
        print_no_schedule and return if list.empty?

        list.each do |s|
          formatter.schedule(s.date, s.option)
        end
      end

      private

      def print_no_schedule
        puts "There is no schedule in the period."
      end
    end
  end
end

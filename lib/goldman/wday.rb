# frozen_string_literal: true

module Goldman
  module Wday
    DATA = {
      monday: 1,
      tuesday: 2,
      wednesday: 3,
      thursday: 4,
      friday: 5,
      saturday: 6,
      sunday: 7
    }

    class << self
      def members
        DATA.keys
      end

      def to_name(num)
        DATA.key(num)
      end

      def to_num(name)
        DATA[name]
      end

      def weekday?(name)
        DATA[name] < 6
      end

      def weekend?(name)
        DATA[name] > 5
      end
    end
  end
end

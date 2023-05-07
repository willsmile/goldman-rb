# frozen_string_literal: true

module Goldman
  module Wday
    DATA = {
      Monday: 1,
      Tuesday: 2,
      Wednesday: 3,
      Thursday: 4,
      Friday: 5,
      Saturday: 6,
      Sunday: 7
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

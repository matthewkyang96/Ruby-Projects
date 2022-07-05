require 'colorize'

class Tile
    attr_reader :value, :prev_val

    def initialize(value)
        @value = value
        @given = value == 0 ? false : true
        @prev_vals = []
    end

    def given?
        @given
    end

    def color
        given? ? :blue : :red
    end

    def to_s
        value == 0 ? "-" : value.to_s.colorize(color)
    end

    def value=(new_val)
        if given?
            puts "Can't change given values"
        else
            @prev_vals << @value
            @value = new_val
        end
    end

    def ==(value)
        self.value == value
    end

end
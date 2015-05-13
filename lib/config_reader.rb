
class ConfigReader

    attr_reader :lines, :raw_lines

    RX_COMMENT = /^#|^\s*$/

    def initialize(config_body)
      @raw_lines = config_body.split("\n")
      @lines = @raw_lines.reject {|l| l =~ RX_COMMENT}
    end
end

class ConfigReader

    attr_reader :lines, :raw_lines, :config

    RX_COMMENT = /^#|^\s*$/

    def initialize(config_body)
      @raw_lines = config_body.split("\n")
      @lines = @raw_lines.reject {|l| l =~ RX_COMMENT}
      @config = parse(@lines)
    end

    def parse(lines)
      split_lines = lines.map {|l| split_key_value(l) }
      Hash[*split_lines.flatten]
    end
    def split_key_value(line)
      k,v = line.split("=")
      [k.strip, v.strip]
    end
    def keys
      @config.keys
    end


end
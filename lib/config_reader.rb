
class ConfigReader

    attr_reader :lines

    def initialize(config_body)
      @lines = config_body.split("\n")
    end
end
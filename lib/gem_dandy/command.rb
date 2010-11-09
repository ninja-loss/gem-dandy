module GemDandy
  class Command
    attr_reader :options

    def initialize( options )
      @options = options
    end
  end
end
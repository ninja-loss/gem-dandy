module GemDandy
  module Output
    def report( *args )
      puts *args
    end

    def die( *args )
      Trollop::die *args
    end
  end
end
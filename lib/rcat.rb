module RCat
  class Application
    def initialize(argv)
      @params, @files = parse_options(argv)
      @display       = Display.new(@params)
    end

    def run
      @files.each { |f| @display.render_file(f) }
    end

    def parse_options(argv)
      params = {}
      files  = OptionParser.new do |parser|
        parser.on("-n") { params[:line_numbering] = :all_lines         }
        parser.on("-b") { params[:line_numbering] = :significant_lines }
        parser.on("-s") { params[:squeeze]        = true               }
      end.parse(argv)

      [params, files]
    end
  end

  class Display
    def initialize(params)
      @params = params
    end

    def render_file(filename)
      # intentionally using print instead of puts here.
      File.foreach(filename) { |line| print line }
    end
  end
end

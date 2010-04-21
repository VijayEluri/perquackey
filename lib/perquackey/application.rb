require 'optparse'

module Perquackey
  class Application
    def self.run!(argv) #:nodoc:
      new.run!(argv)
    end

    def initialize
      @defaults = %w(--console)

      @options  = OptionParser.new do |opts|
        opts.banner  = "Usage: #{File.basename($0)} [-c|-s]"
        opts.version = Perquackey::VERSION
        opts.separator ''

        opts.on('-c', '--console', 'Run an interactive console.') do
          @mode = :console
        end

        opts.on('-s', '--server[=port]', 'Run an http server.') do |port|
          @mode = :server
          @port = port || 3000
        end

        opts.separator ''
        opts.separator 'Defaults:'
        opts.separator "#{opts.summary_indent}#{@defaults.join(' ')}"
      end
    end

    def run!(argv)
      begin
        @options.parse(@defaults.dup.concat(argv))
      rescue OptionParser::ParseError
        @options.abort($!)
      end

      case @mode
      when :console
        Perquackey::Console.run!
      when :server
        Perquackey::Server.run!(:port => @port)
      end
    end
  end
end

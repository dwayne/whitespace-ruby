module Whitespace
  module ISA
  end
end

require_relative "instructions/instruction"
Dir.glob(File.expand_path("instructions/**/*.rb", File.dirname(__FILE__))) do |f|
  require f
end

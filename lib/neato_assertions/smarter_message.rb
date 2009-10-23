module NeatoAssertions
  module SmarterMessage
    mattr_accessor :context_lines
    @@context_lines = 2
    
    def self.included(klass)
      klass.class_eval do
        alias_method_chain :assert_block, :smarter_message unless method_defined?(:assert_block_without_smarter_message)
      end
    end
    
    def assert_block_with_smarter_message(*args, &blk)
      assert_block_without_smarter_message(*args, &blk)
    rescue Test::Unit::AssertionFailedError => e
      backtrace = e.backtrace
      relevant_traces = relevant_traces(backtrace)
      raise if relevant_traces.blank?
      new_error = Test::Unit::AssertionFailedError.new e.message + "\n" + message_for_backtrace(backtrace)
      new_error.set_backtrace(relevant_traces)
      raise new_error
    end

    private

    def message_for_backtrace(backtrace)
      trace = first_relevant_trace(backtrace)
      line = line_at_backtrace(trace, SmarterMessage.context_lines)
      "#{trace}\n#{line}"
    end

    def relevant_traces(backtrace)
      backtrace.select { |trace| trace =~ /_test\.rb/}.reject{|trace| trace =~ /#{File.basename(__FILE__)}/}
    end

    def first_relevant_trace(backtrace)
      backtrace.detect { |trace| trace =~ /_test\.rb/}
    end

    def line_at_backtrace(trace, context = 0)
      file, line = trace.split(":")
      line = line.to_i - 1
      start, finish = line - context, line + context
      lines = File.open(file).readlines
      (start..finish).map do |line_number|
        "#{line_number == line.to_i ? "-->" : "   "} #{line_number + 1}: #{lines[line_number].rstrip}"
      end.join("\n")
    end
  end
end
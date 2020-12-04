# frozen_string_literal: true
require 'readline'
require 'singleton'
require 'set'

module RubyListComprehension
  FM_REGEX = /for(?<parameter>.*)(?=in)in(?<iterable>.*)(?=do)do(?<mappable>.*)(?=if)if(?<filterable>.+)end/.freeze
  F_REGEX = /for(?<parameter>.*)(?=in)in(?<iterable>.*)(.+)do(.+)(?=if)if(?<filterable>.*)end/.freeze
  M_REGEX = /(?=for)for(?<parameter>.*)(?=in)in(?<iterable>.*)(?=do)do(?<mappable>.*)(?=end)end/.freeze
  I_REGEX = /for(?<parameter>.*)(?=in)in(?<iterable>.*)(?=do)do(?<identity>.+)(?=end)end/.freeze

  private

  def fetch_capture(data, name)
    data[name.to_sym] if data.names.include?(name.to_s) && !data.nil?
  end

  def op_type(str)
    match_map = str.match(M_REGEX)
    match_filter_map = str.match(FM_REGEX)
    match_filter = str.match(F_REGEX)
    match_identity = str.match(I_REGEX)
    parameter = fetch_capture(match_identity, :parameter)
    mappable = fetch_capture(match_map, :mappable)
    map_condition = mappable.split('if')[0]

    if match_filter_map.nil? && match_filter.nil? && (parameter.strip == mappable.strip || /\A\s*\Z/ === mappable)
      return :identity
    elsif match_filter_map.nil? && match_filter.nil?
      return :map
    end

    if fetch_capture(match_map, :mappable).include?('if') &&
      !(parameter.strip == map_condition.strip || /\A\s*\Z/ === mappable)
      :filter_map
    else
      if match_identity[:parameter].strip == match_filter[:filterable].strip
        return :identity
      end
      :filter
    end
  end

  def denest_builder(nested_list)
    nested_list.split('[')
      .delete_if{|x| x == ""}
      .map{|str|str[0..-1] + " end"}
      .join.split('],')
      .join.split(' end')
      .map{|x|"#{x} end"}
  end

  def denest_flattener(nested_list)
    nested_list.split(" end")
     .join
     .split(' end')
     .split('for')[1..-1]
     .map!{|x|"for#{x} end"}
  end

  def create_protocol(denested_array, operator_array)
    operator_array.each_with_object({}).with_index do |(e, o), i|
      case e
      when :filter
        o[i] = [e, denested_array[i].match(F_REGEX)]
      when :filter_map
        o[i] = [e, denested_array[i].match(FM_REGEX)]
      when :map
        o[i] = [e, denested_array[i].match(M_REGEX)]
      when :identity
        o[i] = [e, denested_array[i].match(I_REGEX)]
      end
    end
  end

  def execute_comprehension(hash, flatten = true)
    $process_str = ''
    op_array = hash.values.map{|x,|x}
    start_index = op_array.length - 1
    nested = op_array.length > 1
    match_data_array = hash.values.map{|_,x|x}

    i = 0
    until op_array.empty?
      current_data = match_data_array[i]
      $iterable_string = fetch_capture(current_data, 'iterable')
      $mappable = fetch_capture(current_data, 'mappable')
      $parameter = fetch_capture(current_data, 'parameter')
      $filterable = fetch_capture(current_data, 'filterable')
      $identity = fetch_capture(current_data, 'identity')
      $iterable = Array($iterable) if $iterable.class == Set
      $iterable = fetch_capture(current_data, 'iterable') if i != 0
      $iterable = $iterable_string if !flatten && @nested
      case op_array.shift
      when :identity
        flatten = @flattener
        if !@nested
          return *$iterable
        elsif i.zero? && !@flattener
          $process_str += "(#{$iterable}).map"
        elsif i.zero? && @flattener
          $process_str += "(#{$iterable}).flat_map"
        elsif !i.zero? && i != start_index
          $process_str += "{(#{$iterable}).map"
        elsif i == start_index
          $process_str += "{(#{$iterable_string}).map(&:itself)"
          $process_str += '}' * (start_index)
        elsif nested && i.zero? && !flatten
          $process_str += "(#{$iterable}).map"
        elsif i != 0 && nested
          $process_str += "(#{$iterable_string}).map"
        end
      when :map
        if i == 0
          $mappable = $parameter if /\A\s*\Z/ === $mappable
          $process_str += "(#{$iterable}).map{|#{$parameter}|(#{$mappable})}"
        elsif i == 0 && flatten
          $mappable = $parameter if /\A\s*\Z/ === $mappable
          $process_str += "(#{$iterable}).flat_map{|#{$parameter}|(#{$mappable})"
        elsif i == 0 && !flatten
          $mappable = $parameter if /\A\s*\Z/ === $mappable
          $process_str += "(#{$iterable}).map{|#{$parameter}|(#{$mappable})"
        elsif i == start_index
          $mappable = $parameter if /\A\s*\Z/ === $mappable
          $process_str += "{(#{$iterable}).map{|#{$parameter}|(#{$mappable})"
          $process_str += '}' * (start_index+1)
        elsif i != start_index
          $process_str += "{(#{$iterable_string}).map{|#{$parameter}|(#{$mappable})"
        end
      when :filter
        if op_array.empty?
          $process_str += "(#{$iterable}).filter{|#{$parameter}|(#{$filterable})}"
        end
      when :filter_map
        if op_array.empty? && RUBY_VERSION >= '2.7.0'
          $process_str += "(#{$iterable}).filter_map{|#{$parameter}|(#{$mappable})  if  (#{$filterable})}"
        else
          $process_str += "(#{$iterable}).map{|#{$parameter}|(#{$mappable})  if  (#{$filterable})}.compact"
        end
      end
      i += 1
    end
    begin
      instance_eval($process_str)
    rescue SyntaxError => e
      "List incomprehensible: #{e.backtrace_locations.to_s}"
    rescue Error => e
      "Check your assumptions, something is amiss: #{e.backtrace_locations.to_s}"
    end
  end

  def one_shot(str)
    len = str.scan('for ').length
    @nested = len > 1
    if @nested
      nest_mode = str.include?('end end') && !@nested ? :flatten : :matrix
      nest_array = @flattener ? denest_flattener(str) : denest_builder(str)
    else
      nest_array = [str]
    end
    op_array = nest_array.map(&method(:op_type))
    hash = create_protocol(nest_array, op_array)
    begin
      execute_comprehension(hash, nest_mode==@nested)
    rescue SyntaxError => se
      puts 'RESCUED!' + se.backtrace_locations.to_s
    end
  end

  class ListComprehension
    include Singleton
    include RubyListComprehension
    attr_accessor :cache, :mappable, :filterable, :line, :flattener

    :TOO_MANY_COMPS_ON_ONE_LINE

    def [](*iterable)
      return [] if iterable.empty? || iterable.nil?

      @flattener = iterable.length == 1
      $iterable = iterable[0] if iterable.length == 1

      @filename = $PROGRAM_NAME
      if @filename == "pry" || @filename == "irb"
        @line = locate_list_repl
      else
        @line = locate_list_file
      end
      return @line if @line == :TOO_MANY_COMPS_ON_ONE_LINE
      return @cache[@line] if @cache.has_key?(@line)

      @cache[@line] = one_shot(@line)
    end

    private

    def initialize
      @cache = {}
    end

    def locate_list_repl
      @line = Readline::HISTORY.to_a.reverse.uniq.reverse[-1]
      start = @line.index('l[') + 2
      ending = @line[start..-1].index('end') + 6
      @line = @line[start...ending]
    end

    def retrieve_file_data
      @file = File.open($PROGRAM_NAME)
      file_data = @file.readlines.map(&:chomp)
      @file.close
      file_data
    end

    def locate_list_file
      @line = retrieve_file_data[caller_locations.last.to_s.scan(/\d+/).last.to_i - 1]
                .strip.match(/\$l(?<line>.+)/)[:line][0...-1]
                .sub(";", " do ")
      @line = :TOO_MANY_COMPS_ON_ONE_LINE if @line.include?("$l")
      @line
    end
  end
  $l = ListComprehension.instance
end

#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.6
# from Racc grammer file "".
#

require 'racc/parser.rb'

require 'rack/mount/regexp/tokenizer'

module Rack
  module Mount
    class RegexpParser < Racc::Parser


def parse_regexp(regexp)
  unless regexp.is_a?(RegexpWithNamedGroups)
    regexp = RegexpWithNamedGroups.new(regexp)
  end

  expression = scan_str(regexp.source)
  expression.ignorecase = regexp.casefold?

  unless Const::SUPPORTS_NAMED_CAPTURES
    @capture_index = 0
    tag_captures!(regexp.names, expression)
  end

  expression
rescue Racc::ParseError => e
  puts "Failed to parse #{regexp.inspect}: #{e.message}" if $DEBUG
  raise e
end

def tag_captures!(names, group)
  group.each do |child|
    if child.is_a?(Group)
      if child.capture
        child.name = names[@capture_index]
        @capture_index += 1
      end
      tag_captures!(names, child)
    elsif child.is_a?(Array)
      tag_captures!(names, child)
    end
  end
end


class Node < Struct.new(:left, :right)
  def flatten
    if left.is_a?(Node)
      left.flatten + [right]
    else
      [left, right]
    end
  end
end

class Expression < Array
  attr_accessor :ignorecase

  def initialize(ary)
    if ary.is_a?(Node)
      super(ary.flatten)
    else
      super([ary])
    end
  end

  def casefold?
    ignorecase
  end
end

class Group < Struct.new(:value)
  attr_accessor :quantifier, :capture, :name

  def initialize(*args)
    @capture = true
    super
  end

  def to_regexp
    value.map { |e| e.regexp_source }.join
  end

  def regexp_source
    "(#{capture ? '' : '?:'}#{value.map { |e| e.regexp_source }.join})#{quantifier}"
  end

  def capture?
    capture
  end

  def ==(other)
    self.value == other.value &&
      self.quantifier == other.quantifier &&
      self.capture == other.capture &&
      self.name == other.name
  end
end

class Anchor < Struct.new(:value)
end

class CharacterRange < Struct.new(:value)
  attr_accessor :negate, :quantifier

  def regexp_source
    if value == '.' || value == '\d'
      "#{value}#{quantifier}"
    else
      "[#{negate && '^'}#{value}]#{quantifier}"
    end
  end

  def include?(char)
    Regexp.compile("^#{regexp_source}$") =~ char.to_s
  end

  def ==(other)
    self.value == other.value &&
      self.negate == other.negate &&
      self.quantifier == other.quantifier
  end
end

class Character < Struct.new(:value)
  attr_accessor :quantifier

  def regexp_source
    "#{value}#{quantifier}"
  end

  def ==(other)
    self.value == other.value &&
      self.quantifier == other.quantifier
  end
end
##### State transition tables begin ###

racc_action_table = [
     3,    35,     5,     6,     7,     8,    42,    10,    33,    34,
     3,     2,     5,     6,     7,     8,    41,    10,    37,    32,
     3,     2,     5,     6,     7,     8,    18,    10,    43,    44,
     3,     2,     5,     6,     7,     8,    19,    10,    45,    46,
     3,     2,     5,     6,     7,     8,    26,    10,   nil,    26,
   nil,     2,    23,    24,    25,    23,    24,    25,    27,   nil,
   nil,    28,    29,    30,    38,   nil,   nil,    28,    29,    30,
    14,   nil,    15,    16,    17,    15,    16,    17 ]

racc_action_check = [
     0,    20,     0,     0,     0,     0,    37,     0,    19,    19,
    34,     0,    34,    34,    34,    34,    37,    34,    25,    18,
    33,    34,    33,    33,    33,    33,     9,    33,    39,    40,
    10,    33,    10,    10,    10,    10,    10,    10,    42,    45,
    11,    10,    11,    11,    11,    11,    12,    11,   nil,    21,
   nil,    11,    12,    12,    12,    21,    21,    21,    13,   nil,
   nil,    13,    13,    13,    31,   nil,   nil,    31,    31,    31,
     3,   nil,     3,     3,     3,    14,    14,    14 ]

racc_action_pointer = [
    -2,   nil,   nil,    66,   nil,   nil,   nil,   nil,   nil,    26,
    28,    38,    38,    55,    69,   nil,   nil,   nil,    19,    -3,
    -9,    41,   nil,   nil,   nil,    11,   nil,   nil,   nil,   nil,
   nil,    61,   nil,    18,     8,   nil,   nil,    -1,   nil,    18,
    19,   nil,    31,   nil,   nil,    22,   nil ]

racc_action_default = [
   -29,    -6,   -23,   -29,   -11,   -22,    -9,   -10,   -12,   -29,
   -29,    -1,    -5,   -29,   -29,   -17,   -16,   -18,   -29,   -29,
   -29,    -3,    -4,   -24,   -25,   -29,   -26,    -7,   -14,   -13,
   -15,   -29,    47,   -29,   -29,   -19,    -2,   -29,    -8,   -29,
   -29,   -28,   -29,   -20,   -21,   -29,   -27 ]

racc_goto_table = [
     9,    13,    22,    21,   nil,   nil,   nil,   nil,   nil,   nil,
    20,    36,    31,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    39,    40 ]

racc_goto_check = [
     1,     6,     4,     3,   nil,   nil,   nil,   nil,   nil,   nil,
     1,     4,     6,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,     1,     1 ]

racc_goto_pointer = [
   nil,     0,   nil,    -8,   -10,   nil,    -2,   nil ]

racc_goto_default = [
   nil,   nil,    11,    12,   nil,     1,   nil,     4 ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 19, :_reduce_1,
  3, 20, :_reduce_2,
  2, 20, :_reduce_3,
  2, 20, :_reduce_4,
  1, 20, :_reduce_none,
  1, 21, :_reduce_none,
  3, 21, :_reduce_7,
  4, 21, :_reduce_8,
  1, 21, :_reduce_9,
  1, 21, :_reduce_10,
  1, 21, :_reduce_11,
  1, 21, :_reduce_12,
  2, 24, :_reduce_13,
  2, 24, :_reduce_14,
  2, 24, :_reduce_15,
  1, 24, :_reduce_none,
  1, 24, :_reduce_none,
  1, 24, :_reduce_none,
  3, 23, :_reduce_19,
  5, 23, :_reduce_20,
  5, 23, :_reduce_21,
  1, 25, :_reduce_none,
  1, 25, :_reduce_none,
  1, 22, :_reduce_none,
  1, 22, :_reduce_none,
  1, 22, :_reduce_none,
  5, 22, :_reduce_27,
  3, 22, :_reduce_28 ]

racc_reduce_n = 29

racc_shift_n = 47

racc_token_table = {
  false => 0,
  :error => 1,
  :LBRACK => 2,
  :RBRACK => 3,
  :L_ANCHOR => 4,
  :CHAR_CLASS => 5,
  :DOT => 6,
  :CHAR => 7,
  :QMARK => 8,
  :LPAREN => 9,
  :RPAREN => 10,
  :COLON => 11,
  :NAME => 12,
  :R_ANCHOR => 13,
  :STAR => 14,
  :PLUS => 15,
  :LCURLY => 16,
  :RCURLY => 17 }

racc_nt_base = 18

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "LBRACK",
  "RBRACK",
  "L_ANCHOR",
  "CHAR_CLASS",
  "DOT",
  "CHAR",
  "QMARK",
  "LPAREN",
  "RPAREN",
  "COLON",
  "NAME",
  "R_ANCHOR",
  "STAR",
  "PLUS",
  "LCURLY",
  "RCURLY",
  "$start",
  "expression",
  "branch",
  "atom",
  "quantifier",
  "group",
  "bracket_expression",
  "anchor" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

def _reduce_1(val, _values, result)
 result = Expression.new(val[0]) 
    result
end

def _reduce_2(val, _values, result)
            val[1].quantifier = val[2]
            result = Node.new(val[0], val[1])
          
    result
end

def _reduce_3(val, _values, result)
 result = Node.new(val[0], val[1]) 
    result
end

def _reduce_4(val, _values, result)
            val[0].quantifier = val[1]
            result = val[0]
          
    result
end

# reduce 5 omitted

# reduce 6 omitted

def _reduce_7(val, _values, result)
 result = CharacterRange.new(val[1]) 
    result
end

def _reduce_8(val, _values, result)
 result = CharacterRange.new(val[2]); result.negate = true 
    result
end

def _reduce_9(val, _values, result)
 result = CharacterRange.new(val[0]) 
    result
end

def _reduce_10(val, _values, result)
 result = CharacterRange.new(val[0]) 
    result
end

def _reduce_11(val, _values, result)
 result = Anchor.new(val[0]) 
    result
end

def _reduce_12(val, _values, result)
 result = Character.new(val[0]) 
    result
end

def _reduce_13(val, _values, result)
 result = val.join 
    result
end

def _reduce_14(val, _values, result)
 result = val.join 
    result
end

def _reduce_15(val, _values, result)
 result = val.join 
    result
end

# reduce 16 omitted

# reduce 17 omitted

# reduce 18 omitted

def _reduce_19(val, _values, result)
 result = Group.new(val[1]) 
    result
end

def _reduce_20(val, _values, result)
 result = Group.new(val[3]); result.capture = false 
    result
end

def _reduce_21(val, _values, result)
 result = Group.new(val[3]); result.name = val[2] 
    result
end

# reduce 22 omitted

# reduce 23 omitted

# reduce 24 omitted

# reduce 25 omitted

# reduce 26 omitted

def _reduce_27(val, _values, result)
 result = val.join 
    result
end

def _reduce_28(val, _values, result)
 result = val.join 
    result
end

def _reduce_none(val, _values, result)
  val[0]
end

    end   # class RegexpParser
    end   # module Mount
  end   # module Rack

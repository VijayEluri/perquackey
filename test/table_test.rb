require 'helper'

class TableTest < Test::Unit::TestCase
  def test_handles_empty_list
    empty_table = Perquackey::Table.new %w()

    assert_equal [], empty_table.headers.to_a
    assert_equal [], empty_table.to_a
  end

  def test_handles_some_list
    table = Perquackey::Table.new %w(ape bear cat dog eagle fox goose hippo ibis)

    assert_equal [3, 4, 5], table.headers.to_a

    assert_equal [
      ['ape', 'bear', 'eagle'],
      ['cat', 'ibis', 'goose'],
      ['dog', '    ', 'hippo'],
      ['fox', '    ', '     ']
    ], table.to_a
  end

  def test_to_s
    table = Perquackey::Table.new %w(ape bear cat dog eagle fox goose hippo ibis)

    assert_equal <<-END.gsub(/^ */, '').strip, table.to_s.strip
      ape bear eagle
      cat ibis goose
      dog      hippo
      fox
    END
  end
end

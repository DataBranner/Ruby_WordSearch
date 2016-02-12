# Word Search, Release 1, by DFS.

=begin
Plan:

Traverse puzzle, noting in hash those cells containing letters of the word.
If all letters not found, note failure with ":failed" sentinel in hash. Presence of this sentinel leads to `false` return value for `snaking_include?`.

High-level model: depth-first search
=end

PUZZLE = [
  ["a", "k", "f", "o", "x", "e", "s"], 
  ["s", "o", "a", "w", "a", "h", "p"], 
  ["i", "t", "c", "k", "e", "t", "n"],
  ["o", "t", "s", "d", "h", "o", "h"],
  ["s", "e", "x", "g", "s", "t", "a"],
  ["u", "r", "p", "i", "w", "e", "u"],
  ["z", "s", "b", "n", "u", "i", "r"]
]

def snaking_include?(word, puzzle=PUZZLE)
  index = index_letters(word, puzzle)
  if index.include?(:failed)
    return false
  end
  
  chars_remaining = Array.new(word.each_char.to_a).reverse
  first_char = chars_remaining.pop
  index[first_char].each { |cell|
    dfs_recursive(cell, chars_remaining)
  }.any?
end

def dfs_recursive(cell, chars_remaining)
  # Base cases
  if chars_remaining.empty?
    return true
  end
  next_char = chars_remaining.pop
  next_cells = get_adjacent(cell).select { |row,col|
    PUZZLE[row][col] == next_char
  }
  if next_cells.empty?
    return false
  end
  
  # Recursive case
  next_cells.each { |cell|
    dfs_recursive(cell, chars_remaining)
  }.any?
end

# Create hash of char-counts in word
def count_chars(word)
  char_counts = Hash.new(0)
  word.each_char { |char| char_counts[char] += 1 }
  char_counts
end

# Create hash: letter of word => [cell1, cell2, ...]
def index_letters(word, puzzle=PUZZLE)
  char_counts = count_chars(word)
  
  # Create hash indexing word-chars in puzzle
  index = Hash.new()
  puzzle.each_with_index { |row_array, row|
    row_array.each_with_index { |row_element, col|
      char_counts.each { |char, _|
        if char == row_element
          if index.include?(char)
            index[char] << [row, col]
          else
            index[char] = [[row, col]]
          end
        end
      }
    }
  }
  
  # Check that each char in char_counts is also found in index, and that
  # char_count values have index values of higher cardinality; if not, return
  # hash showing only the missing chars, with "failed" sentinel and remark.
  problem_chars = {failed: true}
  char_counts.each { |char, count|
    if !index[char]
      problem_chars[char] = "char #{char} is not found in puzzle"
    elsif index[char].length < count
      found = index[char].length
      problem_chars[char] = (
        "char #{char} needs #{count} cases but puzzle has only #{found}"
        )
    end
  }
  if problem_chars != {failed: true}
    return problem_chars
  end
  index
end

# Given coordinates of a cell, return up to nine adjacent cells, if they exist.
# TODO: "straight_lines" will restrict snaking case to straight-line cases.
def get_adjacent(cell, puzzle=PUZZLE, straight_lines=nil)
  row, col = cell
  [*(row-1..row+1)].product([*(col-1..col+1)]).
    select { |r,c|
      r >= 0 && r < puzzle[0].length &&  # exclude cells off top/bottom edges
      c >= 0 && c < puzzle.length &&     # exclude cells off left/right edges
      [r, c] != [row, col]               # exclude original cell
    }
end


# Below are methods pre-populated by the creators of the challenge, 
# but not implemented.

def straight_line_include?(word, puzzle)
end

require_relative "../word_search"

describe "count_chars" do
 it "handles case 'list' correctly" do
   observed = count_chars('list')
   expected = {"l"=>1, "i"=>1, "s"=>1, "t"=>1}
   expect(observed).to eq(expected)
 end

 it "handles case 'lists' correctly" do
   observed = count_chars('lists')
   expected = {"l"=>1, "i"=>1, "s"=>2, "t"=>1}
   expect(observed).to eq(expected)
 end

 it "handles empty string correctly" do
   observed = count_chars('')
   expected = {}
   expect(observed).to eq(expected)
 end

end

describe "get_adjacent" do
  it "handles case [3,4] correctly" do
    cell = [3,4]
    expect(get_adjacent(cell).length).to eq(8)
  end

  it "handles case [0,4] correctly" do
    cell = [0,4]
    expect(get_adjacent(cell).length).to eq(5)
  end

  it "handles case [4,0] correctly" do
    cell = [4,0]
    expect(get_adjacent(cell).length).to eq(5)
  end

  it "handles case [0,0] correctly" do
    cell = [0,0]
    expect(get_adjacent(cell).length).to eq(3)
  end

  it "handles case [0,6] correctly" do
    cell = [0,6]
    expect(get_adjacent(cell).length).to eq(3)
  end

  it "handles case [6,0] correctly" do
    cell = [6,0]
    expect(get_adjacent(cell).length).to eq(3)
  end

  it "handles case [6,6] correctly" do
    cell = [6,6]
    expect(get_adjacent(cell).length).to eq(3)
  end
end

describe "index_letters" do
  it "handles case 'foxes' correctly" do
     observed = index_letters('foxes')
     expected = {"f"=>[[0, 2]],
                 "o"=>[[0, 3], [1, 1], [3, 0], [3, 5]],
                 "x"=>[[0, 4], [4, 2]],
                 "e"=>[[0, 5], [2, 4], [4, 1], [5, 5]],
                 "s"=>[[0, 6], [1, 0], [3, 2], [4, 0], [4, 4], [6, 1]]
                 }
     expect(observed).to eq(expected)
  end

  it "handles case 'z' correctly" do
    observed = index_letters('z')
    expected = {"z"=>[[6, 0]]}
    expect(observed).to eq(expected)
  end

  it "handles case 'ee' correctly" do
    observed = index_letters('ee')
    expected = {"e"=>[[0, 5], [2, 4], [4, 1], [5, 5]]}
    expect(observed).to eq(expected)
  end

  it "handles case 'j' correctly" do
    observed = index_letters('j')
    expected = {:failed=>true, "j"=>"char j is not found in puzzle"}
    expect(observed).to eq(expected)
  end

  it "handles case 'zz' correctly" do
    observed = index_letters('zz')
    expected = {:failed=>true,
                "z"=>"char z needs 2 cases but puzzle has only 1"
                }
    expect(observed).to eq(expected)
  end
end


describe "snaking_include?" do
  it "handles case 'foxes' (horizontal) correctly" do
    expect(snaking_include?('foxes')).to eq(true)
  end

  it "handles case 'otters' (vertical) correctly" do
    expect(snaking_include?('otters')).to eq(true)
  end

  it "handles case 'bison' (diagonal) correctly" do
    expect(snaking_include?('bison')).to eq(true)
  end

  it "handles case 'zrzzz' (only first two letters found) correctly" do
    expect(snaking_include?('zrzzz')).to eq(false)
  end

  it "handles case 'jjjjj' (letters not found at all) correctly" do
    expect(snaking_include?('jjjjj')).to eq(false)
  end

  it "handles case 'nighthawks' (true snaking case) correctly" do
    expect(snaking_include?('nighthawks')).to eq(true)
  end
end

# Below are tests pre-populated by the creators of the challenge.
# Not implemented here.

describe "straight_line_include?" do
end



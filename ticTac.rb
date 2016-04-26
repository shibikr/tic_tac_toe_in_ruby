class TicTacToe

  @@player1_inputs = []
  @@player2_inputs = []
  @@player1 = ""
  @@player2 = ""
  @@winner = ""
  @@winning_combinations = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  @@board = []

  def create_board
    inner_line = Array.new(48," ")
    vertical_line_positions = [0,15,31,46]
    vertical_line_positions.each do |x|
      inner_line.insert(x,"|")
    end
    boarder_line = Array.new(47,"_")
    horizontal_line_positions = [0,8,16,24];
    lines = Array.new(24)
    lines = lines.map do |x|
      inner_line.clone
    end
    horizontal_line_positions.each do |x|
      lines[x]=boarder_line
    end
    @@board = lines
  end

  def mark_column_number(lines)
    lines[1][13] = 1
    lines[1][29] = 2
    lines[1][44] = 3
    lines[9][13] = 4
    lines[9][29] = 5
    lines[9][44] = 6
    lines[17][13] = 7
    lines[17][29] = 8
    lines[17][44] = 9
  end

  def mark_user_input_on_board(lines,player_name,column_no)
    if player_name == @@player1
      symbol = "#"
    else
      symbol = "&"
    end

    case column_no
      when 1
        lines[4][7] = symbol
      when 2
        lines[4][22] = symbol
      when 3
        lines[4][38] = symbol
      when 4
        lines[12][7] = symbol
      when 5
        lines[12][22] = symbol
      when 6
        lines[12][38] = symbol
      when 7
        lines[20][7] = symbol
      when 8
        lines[20][22] = symbol
      when 9
        lines[20][38] = symbol
    end
  end

  def print_board(column = nil,player_name = nil)
    mark_column_number(@@board)
    mark_user_input_on_board(@@board,player_name,column)
    @@board.map do |x|
      puts x.join
    end
    puts
  end

  def input_player_details
    print "Enter the first player name"
    puts
    @@player1 = gets
    print "Enter the second player name"
    puts
    @@player2 = gets
  end

  def decide_winner
    if @@player1_inputs.size == 3 && @@winning_combinations.include?(@@player1_inputs.sort)
      @@winner = @@player1
      return true
    elsif @@player2_inputs.size ==3 && @@winning_combinations.include?(@@player2_inputs.sort)
      @@winner = @@player2
      return true
    end
    return false
  end

  def validate_input_number(number)
    if number >9 || number < 1
      puts "Enter any number from 1 to 9 "
      return false
    elsif (@@player1_inputs+@@player2_inputs).include?(number)
      puts "Sorry, number already entered"
      puts "Enter another number"
      return false
    end
    return number
  end

  def validate_and_add_number(input_number,array,player_name)
    number = validate_input_number(input_number)
    while true
      if number == false
        input_number = gets
        number = validate_input_number(input_number.to_i)
      else
        break
      end
    end
    array.push(number.to_i)
    print_board(number.to_i,player_name)
  end

  # def print_output(player_input,player_totall_inputs,player_name)
  #   if decide_winner
  #     puts "Game over!!! The winner is #{@@winner}"
  #     return
  #   else
  #     print "player1!!!  Enter one column number"
  #     puts
  #     player1Input = gets
  #     validate_and_add_number(player_input.to_i,player_totall_inputs,player_name)
  #   end
  # end

  def input_column_number
    print_board()
    maximum_turns = 4
    i = 0
    while i < maximum_turns
      if decide_winner
        puts "Game over!!! The winner is #{@@winner}"
        return
      else
        puts "#{@@player1}!!!  Enter one column number"
        player1_input = gets
        validate_and_add_number(player1_input.to_i,@@player1_inputs,@@player1)
      end
      if decide_winner
        puts "Game over!!! The winner is #{@@winner}"
        return
      else
        puts "#{@@player2}!!! Enter one column number"
        player2_input = gets
        validate_and_add_number(player2_input.to_i,@@player2_inputs,@@player2)
      end
        i+=1
    end
    puts "Game over!! no one won the game"
  end
end

game = TicTacToe.new
game.create_board
game.input_player_details
game.input_column_number

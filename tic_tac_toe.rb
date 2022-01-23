require 'pry-byebug'

class Game


    attr_accessor :board

    def initialize ()
        @board = [
            [' ', '|', ' ', '|', ' '],
            [' ', '|', ' ', '|', ' '],
            [' ', '|', ' ', '|', ' ']
        ]

    end
    
    def empty_row(row)
        3.times do |i|
            if board[row][i] == ' '
                return true
            end
        end
        return false
    end

    def empty_column (column)
        3.times do |i|
            if board[i][column] == ' '
                return true
            end
        end
        return false
    end

    def empty_diagonal?
        n = 2
        3.times do |i|
            board[i].delete('|')
            if board[i][i] == ' '
                result = 1
            end
            if board[i][n] == ' '
                result2 = 1
            end
            board[i].insert(1, '|')
            board[i].insert(3, '|')
            return true if result == 1 && result2 == 1

            n -= 1

        end
        false
    end

end

class WinningConditions < Game

    def row_win (row)
        unless empty_row (row)
            if board[row][0] == board[row][2] && board[row][2] == board[row][4]
                winning_team = board[row][0]
                return winning_team
            end
        end
        return false
    end

    def column_win (column)
        3.times do
            unless empty_column (column)
                if board[0][column] == board[1][column] && board[1][0] == board[2][column]
                    winning_team = board[0][column]
                    return winning_team
                end
            end
        end
        return false
    end

    def diagonal_win 
        unless empty_diagonal?
            if board[0][0] == board[1][2] && board[1][2] == board[2][4]
                winning_team = board[0][0]
                return winning_team
            elsif board[0][4] == board[1][2] && board[1][2] == board[2][0]
                winning_team = board[0][4]
                return winning_team
            end
        end
        false
    end
end

class Input < WinningConditions
    attr_accessor :human_team, :computer_team

    def initialize
        @human_team = gets.chomp

        @human_team == 'x' ? @computer_team = 'o' : @computer_team = 'x'
        
        @board = [             
        [' ', '|', ' ', '|', ' '],
        [' ', '|', ' ', '|', ' '],
        [' ', '|', ' ', '|', ' ']
        ]

    end

    def display_board
        3.times do |i|
            puts board[i].join
        end
    end

    def update_board (row, column, move)
        if board[row][column] == ' '
            board[row][column] = move
            display_board
            return false
        end
        true
    end

    def computer_move
        puts 'computer move'
        loop do
            empty = update_board(rand(3), rand(3) * 2, computer_team)
            if empty == false
                break
            end
        end
    end

    def human_move
      puts 'human move'
      update_board(gets.to_i, gets.to_i, human_team)

    end

    def check_win
        3.times do |i|
            if row_win(i)
                p '1'
                p row_win(i)
                return row_win(i)
            elsif column_win(i * 2)
                p '2'
                p column_win(i * 2)
                return column_win(i * 2)
            elsif diagonal_win
                p '3'
                p diagonal_win
                return diagonal_win
            end
        end
        false
    end
end

def do_game
    new_game = Input.new
    loop do
        did_win = new_game.check_win
        if did_win
            if did_win == new_game.human_team
                puts "human won"
                return
            end
            puts "computer won"
            return
        end
        new_game.human_move
        new_game.computer_move
    end
end

do_game

# reminder: check what well brewed tea should look like

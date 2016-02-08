class People
  attr_accessor :name
  @@politicians_array = []
  @@voters_array = []
end

class Voter < People
  attr_accessor :party_affiliation
  def initialize(name, party_affiliation)
    @name = name
    @party_affiliation = party_affiliation
  end
end

class Politician < People
  attr_accessor :political_affiliation
  def initialize(name, political_affiliation)
    @name = name
    @political_affiliation = political_affiliation
  end
end

class World < People
  class << self

    def game_intro
      puts "Welcome to the voter simulator!"
    end

    def invalid_response
      "Invalid response. We are taking you back to main menu to try again."
    end

    def main_menu
      puts """What would you like to do?
      (C)reate, (L)ist, (U)pdate, (D)elete, or (E)nd game..."""
      menuchoice = gets.chomp.downcase
      if menuchoice == "c"
        create_menu
      elsif menuchoice == "l"
        list_menu
      elsif menuchoice == "u"
        update_menu
      elsif menuchoice == "d"
        delete_menu
      elsif menuchoice == "e"
        end_game
      else
        invalid_response
        main_menu
      end
    end

    def end_game
      puts "Thank you for playing the voter simulator. I hope you enjoyed yourself!"
    end

    def create_new_politician(name, political_aff)
      p1 = Politician.new(name, political_aff)
      @@politicians_array << {name: p1.name, affiliation: p1.political_affiliation}
      main_menu
    end

    def create_new_voter(name, voter_aff)
      v = Voter.new(name, voter_aff)
      @@voters_array << {name: v.name, affiliation: v.party_affiliation}
      main_menu
    end

    def create_menu
      puts """What would you like to create?
      (P)olitician or (V)oter"""
      create_menu_choice = gets.chomp.downcase
      if create_menu_choice == "p"
        puts """please insert politicians name
        example: Barack"""
        name = gets.chomp.capitalize
        puts "please insert political affiliation. options: Democrat, Republican"
        political_aff = gets.chomp.downcase
        case political_aff
        when "democrat"
          create_new_politician(name, political_aff)
        when "republican"
          create_new_politician(name, political_aff)
        else
          invalid_response
          create_menu
        end
      elsif create_menu_choice == "v"
        puts """please insert the voters name example: savannah"""
        name = gets.chomp.capitalize
        puts """please insert voter affiliation. options: Liberal, Conservative, Tea Party, Socialist, or Neutral"""
        voter_aff = gets.chomp.downcase
        case voter_aff
        when "liberal"
          create_new_voter(name, voter_aff)
        when "conservative"
          create_new_voter(name, voter_aff)
        when "tea party"
          create_new_voter(name, voter_aff)
        when "socialist"
          create_new_voter(name, voter_aff)
        when "neutral"
          create_new_voter(name, voter_aff)
        else
          invalid_response
          create_menu
        end
        main_menu
      else
        puts "Invalid response. We are taking you back to main menu to try again."
        main_menu
      end
    end

    def list_menu
      puts "Here are your politicians #{@@politicians_array}"
      puts "Here are your voters #{@@voters_array}"
      main_menu
    end

    def find_voter(update_choice)
      @@voters_array.each do |voter|
        if voter[:name] == update_choice
          puts "What is the voters new affiliation?"
          new_voter_affiliation = gets.chomp.downcase
          case new_voter_affiliation
          when "liberal"
            voter[:affiliation] = "liberal"
          when "conservative"
            voter[:affiliation] = "conservative"
          when "tea party"
            voter[:affiliation] = "tea party"
          when "socialist"
            voter[:affiliation] = "socialist"
          when "neutral"
            voter[:affiliation] = "neutral"
          else
            invalid_response
            main_menu
          end
        end
      end
    end

    def find_politician(update_choice)
      @@politicians_array.each do |politician|
        if politician[:name] == update_choice
          puts "What is the politicians new affiliation?"
          new_politician_affiliation = gets.chomp.downcase
          case new_politician_affiliation
          when "democrat"
            politician[:affiliation] = "democrat"
          when "republican"
            politician[:affiliation] = "republican"
          else
            invalid_response
            main_menu
          end
        end
      end
    end


    def update_menu
      puts "Who would you like to update? (P or V)"
      update_person = gets.chomp.downcase
      if update_person == "v"
        puts "What voter would you like to update?"
        update_choice = gets.chomp.capitalize
        find_voter(update_choice)
      elsif update_person == "p"
        puts "What politician would you like to update?"
        update_choice = gets.chomp.capitalize
        find_politician(update_choice)
      else
        invalid_response
        main_menu
      end
    end

  def delete_menu
    p @@voters_array
    p @@politicians_array
    puts "Who would you like to delete?"
    delete_choice = gets.chomp.capitalize
    if delete_choice == @@voters_array[0][:name]
      puts "Are you sure you want to delete this voter? (Y or N)"
      delete_choice2 = gets.chomp.downcase
      if delete_choice2 == "y"
        @@voters_array.delete_if { |h| h[:name] == delete_choice}
        main_menu
      else
        main_menu
      end
    elsif delete_choice == @@politicians_array[0][:name]
      puts "Are you sure you want to delete this politician?(Y or N)"
      delete_choice3 = gets.chomp.downcase
      if delete_choice3 == "y"
        @@politicians_array.delete_if { |h| h[:name] == delete_choice}
        main_menu
      else
        main_menu
      end
    else
      invalid_response
      main_menu
    end
  end
end
end


World.game_intro
World.main_menu

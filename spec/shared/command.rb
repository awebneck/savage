module Command
  def extract_coordinates(command_string)
    coordinates = []
    command_string.scan /-?\d+(\.\d+)?/ do |match_group|
      coordinates << $&.to_f
    end
    coordinates
  end
  
  def extract_command(command_string)
    command_string[0,1]
  end
end
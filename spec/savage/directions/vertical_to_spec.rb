require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage::Directions

describe VerticalTo do
  def dir_class; VerticalTo; end
  def create_absolute; VerticalTo.new(100,true); end
  def command_code; 'v'; end
  include CoordinateTargetShared
end

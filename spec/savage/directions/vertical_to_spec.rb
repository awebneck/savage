require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage::Directions

describe VerticalTo do
  def dir_class; VerticalTo; end
  def create_relative; VerticalTo.new(100,false); end
  def command_code; 'v'; end
  it_behaves_like 'CoordinateTarget'
end

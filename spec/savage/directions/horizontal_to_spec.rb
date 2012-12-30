require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage::Directions

describe HorizontalTo do
  def dir_class; HorizontalTo; end
  def create_relative; HorizontalTo.new(100,false); end
  def command_code; 'h'; end
  it_behaves_like 'CoordinateTarget'
end

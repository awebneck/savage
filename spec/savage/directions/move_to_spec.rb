require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage::Directions

describe MoveTo do
  def dir_class; MoveTo; end
  def create_relative; MoveTo.new(100,200,false); end
  def command_code; 'm'; end
  it_behaves_like 'PointTarget'
end

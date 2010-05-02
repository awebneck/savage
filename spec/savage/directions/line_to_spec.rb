require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage::Directions

describe LineTo do
  def dir_class; LineTo; end
  def create_relative; LineTo.new(100,200,false); end
  def command_code; 'l'; end
  include PointTargetShared
end

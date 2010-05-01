require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage::Directions

describe MoveTo do
  def dir_class; MoveTo; end
  def create_absolute; MoveTo.new(100,200,true); end
  def command_code; 'm'; end
  include PointTargetShared
end

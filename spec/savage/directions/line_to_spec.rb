require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage

describe LineTo do
  def dir_class; LineTo; end
  def create_absolute; LineTo.new(100,200,true); end
  def command_code; 'l'; end
  include PointTargetShared
end

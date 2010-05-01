require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage

describe HorizontalTo do
  def dir_class; HorizontalTo; end
  def create_absolute; HorizontalTo.new(100,true); end
  def command_code; 'h'; end
  include CoordinateTargetShared
end

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage

describe MoveTo do
  def dir_class; MoveTo; end
  include PointTargetShared
  describe '#to_command' do
    it 'should start with a capital M when absolute' do
      abs_dir = MoveTo.new(100,200,true)
      extract_command(abs_dir.to_command).should == 'M'
    end
    it 'should start with a lower-case m when not absolute' do
      extract_command(@dir.to_command).should == 'm'
    end
  end
end

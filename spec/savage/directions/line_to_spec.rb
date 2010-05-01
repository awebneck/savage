require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Savage

describe LineTo do
  def dir_class; LineTo; end
  include PointTargetShared
  describe '#to_command' do
    it 'should start with a capital L when absolute' do
      abs_dir = LineTo.new(100,200,true)
      extract_command(abs_dir.to_command).should == 'L'
    end
    it 'should start with a lower-case l when not absolute' do
      extract_command(@dir.to_command).should == 'l'
    end
  end
end

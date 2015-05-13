require 'spec_helper'
require 'config_reader'

describe ConfigReader do
  let(:sample) {
    '
# This is what a comment looks like, ignore it
# All these config lines are valid
host = test.com
server_id=55331
server_load_alarm=2.5
user= user
# comment can appear here as well
verbose =true
test_mode = on
debug_mode = off
log_file_path = /tmp/logfile.log
send_notifications = yes
    '
  }

  subject { ConfigReader.new(sample) }

  it 'should read the lines' do
    expect(subject.raw_lines.count).to eq(14)
  end
  it 'should read the lines without comments' do
    expect(subject.lines.count).to eq(9)
  end
  it 'should parse keys' do
    expect(subject.keys).to eq(
                              %w/host server_id server_load_alarm user
verbose test_mode debug_mode log_file_path send_notifications/
                            )
  end

  describe "comment rx" do
    it 'should filter lines starting hash' do
      expect(["# comment"].grep(ConfigReader::RX_COMMENT)).to eq(["# comment"])
    end
    it 'should filter empty lines' do
      lines = [ 'data-line', '', 'data-line', '    ' ]
      expect(lines.grep(ConfigReader::RX_COMMENT)).to eq( [ '', '    ' ] )
    end
  end
  describe "parse line" do
    it 'should split =' do
      expect(subject.parse(["key=value"])).to eq({'key' => 'value'})
    end

  end
end
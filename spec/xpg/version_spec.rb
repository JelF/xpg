describe 'XPG::VERSION' do
  subject { XPG::VERSION }

  it { is_expected.to match(/\A(\d\.){3}\d.?(-.+)?\z/) }
end

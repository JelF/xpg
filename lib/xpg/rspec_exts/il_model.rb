# Describes XPG::ILModel interface
shared_examples 'XPG::ILModel' do
  let(:_string_rows_set) do
    begin
                             string_rows_set
                           rescue
                             %i(foo bar)
                           end
  end

  def arbitrary(keys = _string_rows_set)
    keys.map { |x| [x.to_s, SecureRandom.hex] }.to_h
  end

  describe 'build' do
    specify 'empty row set' do
      expect(subject.build([])).to be_empty
    end

    specify '1 item' do
      data = arbitrary
      expect(subject.build([data]).map(&:attributes))
        .to match_array [include(data)]
    end

    specify '2 items' do
      data = [arbitrary, arbitrary]
      expect(subject.build(data).map(&:attributes))
        .to match_array(data.map(&method(:include)))
    end
  end
end

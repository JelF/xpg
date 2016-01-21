class DummyAdapter < Adapters::Adapter
  def foo
    123
  end

  def bar
    object.to_s
  end
end

describe Adapters::Adapter do
  subject { DummyAdapter.new(456) }

  describe '#cast' do
    around 'isolation' do |example|
      interface = DummyAdapter.instance_variable_get(:@interface)
      example.run
      DummyAdapter.instance_variable_set(:@interface, interface)
    end

    specify 'interface not defined' do
      expect { subject.cast }.to(
        raise_error(Adapters::TargetInterfaceNotDefined,
                    'Target interface not defined for DummyAdapter')
      )
    end

    specify 'interface defined' do
      interface = double(:interface, interface_methods: %i(foo bar))
      DummyAdapter.interface(interface) # Do not repeat it at home!
      expect(interface).to receive(:new) { |x| x }

      converted = subject.cast
      expect(converted).to be_a Hash
      expect(converted.keys).to match_array interface.interface_methods
      expect(converted[:foo].call).to eq 123
      expect(converted[:bar].call).to eq '456'
    end
  end
end

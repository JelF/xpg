class DummyInterface < Adapters::Interface
  interface_method :foo
  interface_method :bar

  def baz
    [foo, bar].join
  end
end

describe Adapters::Interface do
  describe 'initialize' do
    let(:bindings) { { foo: -> { 123 }, bar: -> { 456 } } }
    subject { DummyInterface.new(bindings) }

    context 'when incomplete' do
      let(:bindings) { { foo: -> { 123 }, baz: -> { 456 } } }

      it 'raises error' do
        expect { subject }
          .to(
            raise_error Adapters::IncompleteInterfaceError,
                        'Missing methods: bar'
          )
      end
    end

    context 'when complete' do
      it 'raises no error' do
        expect { subject }.not_to raise_error
      end

      it 'respond to interface methods' do
        expect(subject.foo).to eq 123
        expect(subject.bar).to eq 456
      end

      it 'responds to other methods' do
        expect(subject.baz).to eq '123456'
      end
    end
  end

  specify 'Adapters.build_interface' do
    interface = Adapters.build_interface(:foo, :bar)
    instance = interface.new(foo: -> { 123 }, bar: -> (x) { x**2 })

    expect(instance.foo).to eq 123
    expect(instance.bar(2)).to eq 4
  end
end

require 'adapters/core_ext'

IExampleInterface = Adapters.build_interface(:foo, :foo=, :bar)

class ExampleAdapter < Adapters::Adapter
  interface IExampleInterface

  def foo
    object.name
  end

  def foo=(x)
    x
  end

  def bar
    123
  end
end

class ExampleInstanceAdapter < Adapters::Adapter
  interface IExampleInterface
  delegate :foo, :foo=, to: :object

  def bar
    547
  end
end

module ExampleModule
  attr_accessor :foo

  class_adapter ExampleAdapter
  instance_adapter ExampleInstanceAdapter
end

describe 'Integration' do
  def subject(use_instance = false)
    object = use_instance ? instance : from
    object.cast(IExampleInterface)
  end

  let(:from) { Object }
  let(:instance) { from.new }

  context 'when object have no binded ancestor' do
    it 'could not be casted' do
      expect { subject }.to(
        raise_error(Adapters::AdapterNotFound,
                    'Unable to cast Object to IExampleInterface')
      )
    end

    specify 'instances could not be casted' do
      expect { subject(true) }.to(
        raise_error(Adapters::AdapterNotFound,
                    /Unable to cast #<Object:.+> to IExampleInterface/)
      )
    end
  end

  context 'when object extened ExampleModule' do
    let(:from) { Class.new { include ExampleModule } }

    it 'could be casted' do
      expect { subject }.not_to raise_error
    end

    it 'is good' do
      expect(subject.foo).to be_nil
      expect(subject.public_send(:foo=, 456)).to eq 456
      expect(subject.bar).to eq 123
    end

    describe 'instances' do
      it 'could be casted' do
        expect { subject(true) }.not_to raise_error
      end

      it 'is delicious' do
        expect(subject(true).foo).to eq nil
        expect(subject(true).public_send(:foo=, 222)).to eq 222
        expect(subject(true).foo).to eq 222
        expect(subject(true).bar).to eq 547
      end
    end
  end

  context 'when trying to redefine cast' do
    let(:adapter) do
      Class.new(Adapters::Adapter) { interface IExampleInterface }
    end

    specify 'with bind it raises error' do
      expect { adapter.bind(ExampleModule) }
        .to raise_error(
          Adapters::AlreadyBoundError,
          'Object ExampleModule already bound to ExampleAdapter'
        )
    end

    specify 'with bind_instances it raises error' do
      expect { adapter.bind_instances(ExampleModule) }
        .to raise_error(
          Adapters::AlreadyBoundError,
          'Isntances of ExampleModule already bound to ExampleInstanceAdapter'
        )
    end
  end
end

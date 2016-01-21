describe Adapters::Bindings do
  subject { Adapters::Bindings }

  describe '#cast' do
    let(:adapter) { double(:adapter, new: cast_dummy) }
    let(:result) { double(:result) }
    let(:cast_dummy) { double(:cast_dummy, cast: result) }

    context 'when no way to cast' do
      it 'raises error' do
        expect { Adapters.cast(1, 2) }
          .to raise_error Adapters::AdapterNotFound, 'Unable to cast 1 to 2'
      end
    end

    shared_examples 'it uses adapter' do
      it 'uses adapter' do
        expect(adapter).to receive(:new).with(1).and_return(cast_dummy)
        expect(Adapters.cast(1, 2)).to eq result
      end
    end

    context 'when there is a direct way to cast' do
      before do
        allow(subject).to receive(:bindings).and_return([1, 2] => adapter)
      end

      include_examples 'it uses adapter'

      context 'and also there is way to cast as an instance' do
        let(:bad_adapter) { double :bad_adapter }

        before do
          allow(subject).to(
            receive(:instance_bindings)
              .and_return([1.class, 2] => bad_adapter)
          )
        end

        include_examples 'it uses adapter'

        it 'does not use bad adapter' do
          expect(bad_adapter).not_to receive(:new)
          expect(Adapters.cast(1, 2)).to eq result
        end
      end
    end

    context 'when there is an instance binding' do
      before do
        allow(subject).to(
          receive(:instance_bindings)
            .and_return([1.class, 2] => adapter)
        )
      end

      include_examples 'it uses adapter'
    end

    context 'when ancestor bound' do
      before do
        allow(subject).to(
          receive(:instance_bindings)
            .and_return([Object, 2] => adapter)
        )
      end

      include_examples 'it uses adapter'
    end
  end
end

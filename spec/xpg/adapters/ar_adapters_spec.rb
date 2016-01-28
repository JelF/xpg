describe 'AR adapters' do
  describe XPG::Adapters::ARLModelAdapter do
    subject { Adapters.cast(ARModel, XPG::ILModel) }
    it_behaves_like 'XPG::ILModel'
  end
end

module CognitiveVision
  describe Configuration do
    subject { described_class.new }

    describe '#key' do
      it 'returns nil when unset' do
        expect(subject.key).to be_nil
      end
    end

    describe '#key=' do
      it 'sets the key in configuration' do
        subject.key = '12345'
        expect(subject.key).to eq '12345'
      end
    end
  end
end

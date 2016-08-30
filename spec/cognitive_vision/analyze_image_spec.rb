require 'spec_helper'

module CognitiveVision
  describe AnalyzeImage, :vcr do
    describe '.analyze_image' do
      subject { described_class.analyze_image(url) }

      context 'with a valid url' do
        let(:url) { 'http://vignette4.wikia.nocookie.net/gameofthrones/images/5/56/Jon_Kill_the_Boy.jpg' }

        it 'returns the age' do
          expect(subject.faces.first.age).to eq(32)
        end

        it 'returns the gender' do
          expect(subject.faces.first.gender).to eq('Male')
        end
      end
    end
  end
end

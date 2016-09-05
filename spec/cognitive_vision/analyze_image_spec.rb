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

      context 'with a invalid url' do
        let(:url) { 'http://images.example.com/mynonexistenturl.jpg' }

        it 'raises invalid image url error' do
          expect { subject }.to raise_error(AnalyzeImage::InvalidImageUrlError)
        end
      end

      context 'with a bad quality image' do
        let(:url) { 'http://bit.ly/2bJ7V3w' }

        it 'raises invalid image size error' do
          expect { subject }.to raise_error(AnalyzeImage::InvalidImageSizeError)
        end
      end

      context 'with a untreated error' do
        let(:url) { 'http://bit.ly/2bJ7V3w' }

        it 'raises unknown error' do
          VCR.eject_cassette
          VCR.turned_off do
            stub_request(:any, /.*/)
              .to_return(body: { code: 'AUnknownError', message: 'Error' }.to_json, status: 400)
            expect { subject }.to raise_error(AnalyzeImage::UnknownError)
          end
        end
      end
    end
  end
end

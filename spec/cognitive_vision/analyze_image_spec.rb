require 'spec_helper'

module CognitiveVision
  describe AnalyzeImage, :vcr do
    describe '.analyze_image' do
      subject { described_class.analyze_image(url) }

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

      context 'with API rate limit exceeded' do
        let(:url) { 'http://bit.ly/2bJ7V3w' }

        it 'raises rate limit error' do
          VCR.eject_cassette
          VCR.turned_off do
            stub_request(:any, /.*/)
              .to_return(body: { statusCode: 429, message: 'Rate limit is exceeded. Try again in 15 seconds.' }.to_json,
                         status: 429)
            expect { subject }.to raise_error(RateLimitError)
          end
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

      context 'faces analyzer' do
        subject { described_class.analyze_image(url, [:faces]) }

        context 'with a valid url' do
          let(:url) { 'http://vignette4.wikia.nocookie.net/gameofthrones/images/5/56/Jon_Kill_the_Boy.jpg' }

          it 'returns the age' do
            expect(subject.faces.first.age).to eq(33)
          end

          it 'returns the gender' do
            expect(subject.faces.first.gender).to eq('Male')
          end
        end
      end

      context 'adult analyzer' do
        subject { described_class.analyze_image(url, [:adult]) }

        context 'with an adult image' do
          let(:url) { 'http://bit.ly/2cIyJy1' }

          it 'returns true for adult content' do
            expect(subject.adult.adult_content?).to be_truthy
          end
        end

        context 'without an adult image' do
          let(:url) { 'http://bit.ly/2cLynuH' }

          it 'returns false for adult content' do
            expect(subject.adult.adult_content?).to be_falsey
          end
        end

        context 'with a racy image' do
          let(:url) { 'http://bit.ly/2cgPzCU' }

          it 'returns true for racy content' do
            expect(subject.adult.racy_content?).to be_truthy
          end
        end

        context 'without a racy image' do
          let(:url) { 'http://bit.ly/2bZvQvK' }

          it 'returns false for racy content' do
            expect(subject.adult.racy_content?).to be_falsey
          end
        end
      end

      context 'categories analyzer' do
        subject { described_class.analyze_image(url, :categories) }
        let(:url) { 'http://bit.ly/2cqO4VM' }

        it 'returns the category of the image' do
          expect(subject.categories.first.name).to eq('animal_panda')
        end
      end

      context 'tags analyzer' do
        subject { described_class.analyze_image(url, :tags) }
        let(:url) { 'http://bit.ly/2cg46o2' }

        it 'returns the tags of the image' do
          expect(subject.tags.first.name).to eq('animal')
        end
      end

      context 'description analyzer' do
        subject { described_class.analyze_image(url, :description) }
        let(:url) { 'http://bit.ly/2cmdzpS' }

        it 'returns the tags of the image' do
          expect(subject.description.tags.size).to eq(20)
        end

        it 'returns the captions from the image' do
          expect(subject.description.captions.first.text).to eq('a close up of a bird feeder')
        end
      end
    end
  end
end

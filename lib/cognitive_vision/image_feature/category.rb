module CognitiveVision
  module ImageFeature
    class Category
      def key
        'categories'
      end

      def parse(response)
        response[key].map { |category| CognitiveVision::Category.new(name: category['name'], score: category['score']) }
      end
    end
  end
end

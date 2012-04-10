require 'pry'
require 'api_smith'

module Stackexchange
  class Client
    include APISmith::Client
    base_uri 'https://api.stackexchange.com/2.0'

    METHODS = %w[answers questions badges comments events info posts priviligess search tags]
    # api_key
    def initialize(*args)
      add_query_options! :api_key => args.shift, :site => 'stackoverflow'

      METHODS.each do |m|
        self.class.send(:define_method, m) do |*opts|
          resp = (get "#{m}", :extra_query => opts.shift)
        end
      end
    end


  end
end
binding.pry

# client = Stackexchange::Client.new
# client.questions(:pagesize => '5', :tagged => 'ruby', :filter => '!gek9vwfUmFjvxuErGDgpW_4OqAvm1j7-*zm')

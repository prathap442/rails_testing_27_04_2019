require 'rails_helper'
require 'shoulda-matchers'

RSpec.configure do |config|
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end
RSpec.describe User,type: :model do 
  describe "it verifies the validations" do 
    it { is_expected.to validate_presence_of(:name) }
  end
end
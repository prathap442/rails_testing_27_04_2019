require 'rails_helper'
RSpec.describe User,type: :model do 
  describe "it verifies the validations" do 
    describe "validates the name presence" do
        it { is_expected.to validate_presence_of(:name) }
    end
  end
end
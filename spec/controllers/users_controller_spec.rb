require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe UsersController,type: :controller do 
  describe "expected to use before action for all actions in controller" do 
    #the below example gives the meaning that it tests in such a way that it loads the action load_user before
    #each action in controller
    it "is expected to define before action" do 
      is_expected.to use_before_action(:load_user)
    end
  end

  describe "GET #index" do 
    #the method below tries to conclude that 
    #whether all the users are available or not in the instance variable
    #once in the index action we are 
    before {get :index}
    it "we expect the instance variable users and with data assigned of GET request" do 
       #assigns tries to create an instance variable and by the @users virtually and is being assigned with the value of before{get :index}
       #Now the comparision is done with User.all that is against all the records that exist in the data base
       expect(assigns[:users]).to eq(User.all)
    end
  end
end

#the following is the mistake that i tended to make
#when writing the controller specs then we 
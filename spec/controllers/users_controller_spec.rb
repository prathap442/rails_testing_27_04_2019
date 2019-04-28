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
       #assigns tries to create an instance variable and by the @users virtually with the content of the content being assigned in the Users controller
       #Now the comparision is done with User.all that is against all the records that exist in the data base
       expect(assigns[:users]).to eq(User.all)
    end
  end

  describe "GET #new" do 
    #these are the group of the specs related to the new action wit GET Http verb
    before { get :new}
    #the before above indicates that before every example in the group perform a get request for new action under users controller
    it "checks the assigned instance variable is an instance of User class or not" do 
        #assign[:user] tries to create us the instance variable with the content of the users controller new action
        expect(assigns[:user]).to be_instance_of(User)
    end 

    it "checks the case of the template rendered is new" do
       is_expected.to render_template(:new)
    end
    
    #the example tries to check the case of the template rendered for the action of 
    #GET new is containg application.html.erb
    it "checks the case of the template rendering of application.html.erb" do 
       is_expected.to render_template(:application)
    end
  end
end

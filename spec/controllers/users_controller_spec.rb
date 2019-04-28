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

  describe "GET #create" do 
    #the before is a key word, and is called as "hook" is rspec
    before { post :create,params: params  }
    context 'when the params are correct' do 
        #Use let to define a memoized helper method. The value will be cached across
        #multiple calls in the same example but not across examples
      let(:params) do 
         {user: {name: "Ani"}}
      end
      
      it "is expected to create new user successfully" do 
        expect(assigns[:user]).to be_instance_of(User)
      end

      it "is expected to have the instance name as expected" do
        expect(assigns[:user].name).to eq("Ani")
      end
      
      #the example below first lazy load with the memoized helper let and the value being cached
      #the cached value is not the main content in the below example
      #the example below expects that we redirect the action once params being
      #strictly acceptable to the users index action where it is expected to render index template
      it "is expected to redirect to users path" do 
        is_expected.to redirect_to(users_path)
      end
      
      #the example says that the expected flash message is according to our expectation or not
      #when the right params are being passed 
      it "is expected to set the flash message" do 
        expect(flash[:notice]).to eq('User Created Successfully.')
      end
    end

    context 'when the params are incorrect' do 
      #when we send incorrect params
      #let(:params) this memoizes and stores in the cache
      let(:params) { {user: {name: ''}} }
      it "should give me the messsage that the name can't be blank" do 
        expect(assigns[:user].errors['name']).to eq(['can\'t be blank'])
      end

      it "should render back the new template" do 
        #yes when there are incorrect params being submitted then the template rendered is new
        is_expected.to render_template(:new)
      end
    end
  end

  #edit action 
  describe 'GET #edit' do
    before do
      # something that you want to execute before running `it` block
      get :edit, params: params
    end
   
    context "when the params are valid" do 
      let(:user){ FactoryBot.create(:user)}
      let(:params){ {id: user.id} }
      it "is expected to set the user instance variable" do 
        expect(assigns[:user]).to be_instance_of(User)
      end
      it "should be able to give back us the correct record" do 
        expect(assigns[:user]).to eq(User.find_by(id: user.id))
      end 

      it "should render the edit template when the params are valid" do 
        is_expected.to render_template(:edit)
      end
    end

    context 'when the params are invalid that is user id is invalid' do 
      let(:params) { {id: Faker::Number.number} }
      it "is expected to redirect to users index page" do 
        is_expected.to redirect_to(users_path)
      end

      it "is expected to set flash message when the user record is not found" do 
        expect(flash[:notice]).to eq('User not found.')
      end
    end
  end

  
end

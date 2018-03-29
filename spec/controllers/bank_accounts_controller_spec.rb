require 'rails_helper'

RSpec.describe BankAccountsController, type: :controller do
  login_user 
  let(:valid_attributes) {{ institution: 'Chase', amount: 200, active: true }}
  let(:invalid_attributes) {{ institution: '', amount: 200, active: true }}
  let(:account) { @user.bank_accounts.create! valid_attributes }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      # bank_account = @user.bank_accounts.create! valid_attributes 
      get :show, params: { id: account.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    # bank_account = @user.bank_accounts.create! valid_attributes
    it "returns http success" do
      get :edit, params: { id: account.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do   
    context "with valid params" do
      it "creates a new BankAccount" do 
        expect {
          post :create, params: { bank_account: valid_attributes }
        }.to change(BankAccount, :count).by(1)
      end 

      it "redirects to the created BankAccount" do 
        post :create, params: { bank_account: valid_attributes }
        expect(response).to redirect_to(BankAccount.last)
      end 
    end 

    context "with invalid params" do 
      it "does not create a new bank account" do 
        expect {
          post :create, params: { bank_account: invalid_attributes }
        }.to change(BankAccount, :count).by(0)
      end 
  
      it "returns a success response" do 
        post :create, params: { bank_account: invalid_attributes }
        expect(response).to have_http_status(:success)
      end 
    end 
  end 

  #let runs the method the first time 
  #second time caches the value in a variable 
  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { amount: 220 } }

      it "updates the requested bank account" do 
        account 
        put :update, params: { id: account.id, bank_account: new_attributes }
        expect(account.reload.amount).to eq(new_attributes[:amount])
      end 

      it "redirects to bank account" do 
        account 
        put :update, params: { id: account.id, bank_account: new_attributes }
        expect(response).to redirect_to(account)
      end 
    end 

    context "with invalid params" do 
      it "does not update the bank account" do 
        account 
        put :update, params: { id: account.id, bank_account: invalid_attributes }
        expect(account.institution).to_not eq(invalid_attributes[:institution])
      end 

      it "returns a success response" do 
        account
        put :update, params: { id: account.id, bank_account: invalid_attributes }
        expect(response).to have_http_status(:success)
      end 
    end 
  end 

  describe "DELETE #destroy" do
    it "destroys the requested bank account" do 
      account 
      expect {
        delete :destroy, params: { id: account.id }
      }.to change(BankAccount, :count).by(-1)
    end 

    it "redirects to bank accounts index" do
      delete :destroy, params: { id: account.id }
      expect(response).to redirect_to(bank_accounts_url) 
    end 
  end 

end

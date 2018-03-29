class BankAccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /bank_accounts 
  def index
    @bank_accounts = current_user.bank_accounts
  end

  # GET /bank_accounts/:id
  def show
  end

  # GET /bank_accounts/new
  def new
    @bank_account = current_user.bank_accounts.new
  end

  # GET /bank_accounts/:id/edit
  def edit
  end

  # POST /bank_accounts
  def create
    @bank_account = current_user.bank_accounts.new(account_params)
    if @bank_account.save 
      redirect_to @bank_account, notice: 'Account Created'
    else 
      render :new 
    end 
  end 

  # PUT /bank_accounts/:id
  def update 
    if @bank_account.update(account_params) 
      redirect_to @bank_account, notice: 'Account updated'
    else 
      render :edit
    end 
  end 

  # DELETE /bank_accounts/:id 
  def destroy
    @bank_account.destroy
    redirect_to bank_accounts_url, notice: 'Account Destroyed' 
  end 

  private 

    def set_account
      @bank_account = current_user.bank_accounts.find(params[:id])
    end 

    def account_params
      params.require(:bank_account).permit(:title, :institution, :amount, :description, :active)
    end 
end

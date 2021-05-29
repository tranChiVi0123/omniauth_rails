class Api::V1::TransactionsController < Api::V1::BaseController

  def index
    render json: {message: "Hello Wolrd! "+user.full_name, status: 200}
  end

  def create
    render json: {message: "Forbiden", status: 403} unless account
    @transaction = Transaction.new(t_params)

    if @transaction.valid? && @transaction.save
      render json: {message: @transaction, user_current: user.uid}
    else
      render json: {message: @transaction.errors.messages.to_json }
    end
  end

  private
  def t_params
    params.require(:transaction).permit(:account_id, :amount, :transaction_type)
  end

  def account
    @account ||= user.accounts.where(account_id: t_params[:account_id])
  end
end
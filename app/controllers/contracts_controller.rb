class ContractsController < ApplicationController

  def create
    @contract = Contract.new(contract_params)
    authorize @contract

    if @contract.save
      return redirect_to client_files_path, notice: 'Votre nouvele instance a bien été créé.'
    else
      return redirect_to client_files_path, alert: 'Erreur de saisie.'
    end
  end

  def update
    @contract = authorize policy_scope(Contract).find(params[:id])

    if @contract.update(contract_params)
      return redirect_to client_files_path, notice: 'Vos modifications ont bien été prises en compte.'
    else
      return redirect_to client_files_path, alert: 'Erreur de saisie.'
    end
  end

  private

  def contract_params
    params.require(:contract).permit(
      :customer_id,
      :instance_reason,
      :customer_class,
      :contract_number,
      :explanation,
      :prioritization,
      :monitoring,
      :date_of_consideration,
      :gideon_number
    )
  end
end

class DelegationsController < ApplicationController

  def create
    @delegation = Delegation.new(delegation_params)
    authorize @delegation

    @assistant = @delegation.assistant
    @agent = @delegation.agent

    if @delegation.save
      return redirect_to assistant_path(@assistant.id), notice: "#{@assistant.full_name} est maintenant l'adjoint de #{@agent.full_name}."
    else
      return redirect_to assistant_path(@assistant.id), alert: 'Erreur de saisie.'
    end
  end

  def destroy
    @delegation = authorize policy_scope(Delegation).find(params[:id])
    @delegation.destroy
    redirect_to assistant_path(@delegation.assistant.id), notice: "#{@delegation.assistant.full_name} n'est plus l'adjoint de #{@delegation.agent.full_name}."

    # respond_to do |format|
    #   format.js
    # end
  end

  private

  def delegation_params
    params.require(:delegation).permit(:assistant_id, :agent_id)
  end
end

class CriterionsController < ApplicationController
  before_action :find_criterion, only: [:edit, :update, :destroy]

  def create
    @criterion = Criterion.new(criterion_params)
    authorize @criterion

    if @criterion.save
      return redirect_to admin_dashboard_criteria_path, notice: 'Votre nouveau critère de tri a bien été créé.'
    else
      return redirect_to admin_dashboard_criteria_path, alert: 'Erreur de saisie, veuillez remplir les 2 champs du formulaire.'
    end
  end

  def edit; end

  def update
    if @criterion.update(criterion_params)
      redirect_to admin_dashboard_criteria_path, notice: 'Vos modifications ont bien été prises en compte.'
    else
      render :edit
    end
  end

  def destroy
    @criterion.destroy

    respond_to do |format|
      format.js
    end
  end

  private

  def find_criterion
    @criterion = authorize policy_scope(Criterion).find(params[:id])
  end

  def criterion_params
    params.require(:criterion).permit(:content, :column)
  end
end

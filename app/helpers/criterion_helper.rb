module CriterionHelper
  # criteria columns
  def instance_reason
    'Motif Instance'
  end

  def customer_number
    'N° Client'
  end

  def customer_name
    'Nom du Client'
  end

  def customer_class
    'Class. Client'
  end

  def contract_number
    'N° Contrat'
  end

  def instance_date
    'Date Instance'
  end

  def explanation
    'Explication'
  end

  def prioritization
    "Priorisation"
  end

  def monitoring
    'Suivi'
  end

  def date_of_consideration
    'Date prise en compte'
  end

  def gideon_number
    'N° Gideon'
  end

  def delegation
    'Délégation'
  end

  def criterion_array
    [instance_reason, customer_number, customer_name, customer_class, contract_number, instance_date, explanation, prioritization, monitoring, date_of_consideration, gideon_number, delegation]
  end

  def new_criterion_array
    [instance_reason, customer_class, prioritization, monitoring]
  end

  def agent
    'Agent'
  end
end

require 'faker'


if Rails.env == "production"


  puts 'It is forbidden !'


elsif Rails.env == "development"


  puts 'cleaning database'


  Contract.destroy_all
  Delegation.destroy_all
  Criterion.destroy_all
  Customer.destroy_all
  User.destroy_all


  puts 'generating users'


  # admin
  user0 = User.create({
    email: 'test@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    first_name: 'Mathieu',
    last_name: 'Durant',
    super_admin: true,
    admin: true,
    assistant: true,
    authorized: true
  })

  # agent
  (1..5).each do |id|
    User.create({
      email: Faker::Internet.email,
      password: 'password',
      password_confirmation: 'password',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    })
  end


  puts "#{User.count} users generated"


  puts 'generating criteria'


  array1 = ['Production', "Demande d'information", 'Prestation décès', 'Mise en rente', 'Arbitrage', 'Rachat', 'Demande de transfert', 'Versement complémentaire', 'Modification contrat', 'Autre']
  array2 = ['C0', 'C1', 'C2', 'C3', 'C4']
  array3 = ['P1', 'P2', 'P3']
  array4 = ['Prise en compte par la gestion', 'Prise en compte par premium', 'Attente de retour Agent', 'Traitée', 'Autre']

  array1.each do |content|
    Criterion.create({
      content: content,
      column: 'Motif Instance'
    })
  end

  array2.each do |content|
    Criterion.create({
      content: content,
      column: 'Class. Client'
    })
  end

  array3.each do |content|
    Criterion.create({
      content: content,
      column: "Priorisation"
    })
  end

  array4.each do |content|
    Criterion.create({
      content: content,
      column: 'Suivi'
    })
  end


  puts 'generating super admin delegation'


  Delegation.create({
    assistant_id: user0.id,
    agent_id: user0.id
  })


  puts 'generating first contract'


  customer0 = Customer.create({
    name: 'client test',
    client_number: '00000',
    user_id: user0.id
  })


  puts 'generating first contract'


  Contract.create({
    customer_id: customer0.id,
    instance_reason: 'Autre',
    customer_class: 'C0',
    contract_number: '00000',
    explanation: 'instance test'
  })


  puts 'Done !'

end

FactoryGirl.define do
  factory :person do
  end

  factory :user do
    slug 'username'
  end

  factory :personal_name do
  end

  factory :display_name do
    appellation 'John Doe'
  end

  factory :confirmable do
    address 'test@email.com'
  end

  factory :email do
  end
end

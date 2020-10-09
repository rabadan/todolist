FactoryBot.define do
  factory :task do
    text { 'text task' }
    is_closed { false }
  end
end

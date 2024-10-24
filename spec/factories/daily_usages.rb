# frozen_string_literal: true

FactoryBot.define do
  factory :daily_usage do
    customer
    organization { customer.organization }
    subscription { create(:subscription, customer:) }

    external_subscriptin_id { subscription.external_id }
    from_datetime { Time.current.beginning_of_month }
    to_datetime { Time.current.end_of_month }
    usage { {} }
  end
end
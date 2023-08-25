# frozen_string_literal: true

module V1
  class CustomerUsageSerializer < ModelSerializer
    def serialize
      payload = {
        from_datetime: model.from_datetime,
        to_datetime: model.to_datetime,
        issuing_date: model.issuing_date,
        currency: model.currency,
        amount_cents: model.amount_cents,
        total_amount_cents: model.total_amount_cents,
        taxes_amount_cents: model.taxes_amount_cents,
      }.merge(legacy_values)

      payload.merge!(charges_usage) if include?(:charges_usage)
      payload
    end

    private

    def charges_usage
      ::CollectionSerializer.new(
        model.fees,
        ::V1::ChargeUsageSerializer,
        collection_name: 'charges_usage',
      ).serialize
    end

    def legacy_values
      ::V1::Legacy::CustomerUsageSerializer.new(model).serialize
    end
  end
end

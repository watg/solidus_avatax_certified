# frozen_string_literal: true

module SolidusAvataxCertified
  module Response
    class AddressValidation < SolidusAvataxCertified::Response::Base
      def description
        'Address Validation'
      end

      def validated_address
        @validated_address ||= if success?
                                 result['validatedAddresses'][0]
                               else
                                 {}
                               end
      end

      def messages
        return unless result

        @messages ||= result['messages']
      end

      def success?
        !failed?
      end

      def error?
        return false if suppress_exceptions?

        result['error'].present?
      end

      def failed?
        return false if suppress_exceptions?

        error? || errors_present?
      end

      def messages_present?
        messages.present?
      end

      def detailed_messages
        if error?
          result['error']['details'].map { |m| m['description'] }
        elsif failed?
          messages.map { |m| m['details'] }
        else
          []
        end
      end

      def summary_messages
        if error?
          result['error']['details'].map { |m| m['message'] }
        elsif failed?
          messages.map { |m| m['summary'] }
        else
          []
        end
      end

      private

      def suppress_exceptions?
        !::Spree::Avatax::Config.raise_exceptions && !result
      end

      def errors_present?
        messages_present? && messages.any? { |m| m['severity'] == 'Error' }
      end
    end
  end
end

# Encoding: utf-8
#
# This is auto-generated code, changes will be overwritten.
#
# Copyright:: Copyright 2015, Google Inc. All Rights Reserved.
# License:: Licensed under the Apache License, Version 2.0.
#
# Code generated by AdsCommon library 0.11.2 on 2015-11-18 12:17:15.

require 'ads_common/savon_service'
require 'dfp_api/v201511/premium_rate_service_registry'

module DfpApi; module V201511; module PremiumRateService
  class PremiumRateService < AdsCommon::SavonService
    def initialize(config, endpoint)
      namespace = 'https://www.google.com/apis/ads/publisher/v201511'
      super(config, endpoint, namespace, :v201511)
    end

    def create_premium_rates(*args, &block)
      return execute_action('create_premium_rates', args, &block)
    end

    def create_premium_rates_to_xml(*args)
      return get_soap_xml('create_premium_rates', args)
    end

    def get_premium_rates_by_statement(*args, &block)
      return execute_action('get_premium_rates_by_statement', args, &block)
    end

    def get_premium_rates_by_statement_to_xml(*args)
      return get_soap_xml('get_premium_rates_by_statement', args)
    end

    def update_premium_rates(*args, &block)
      return execute_action('update_premium_rates', args, &block)
    end

    def update_premium_rates_to_xml(*args)
      return get_soap_xml('update_premium_rates', args)
    end

    private

    def get_service_registry()
      return PremiumRateServiceRegistry
    end

    def get_module()
      return DfpApi::V201511::PremiumRateService
    end
  end
end; end; end

#!/usr/bin/env ruby
# Encoding: utf-8
#
# Copyright:: Copyright 2012, Google Inc. All Rights Reserved.
#
# License:: Licensed under the Apache License, Version 2.0 (the "License");
#           you may not use this file except in compliance with the License.
#           You may obtain a copy of the License at
#
#           http://www.apache.org/licenses/LICENSE-2.0
#
#           Unless required by applicable law or agreed to in writing, software
#           distributed under the License is distributed on an "AS IS" BASIS,
#           WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
#           implied.
#           See the License for the specific language governing permissions and
#           limitations under the License.
#
# This code example gets all creative sets for a master creative. To create
# creative sets, run create_creative_sets.rb.

require 'dfp_api'


API_VERSION = :v201505

def get_creative_sets_by_statement()
  # Get DfpApi instance and load configuration from ~/dfp_api.yml.
  dfp = DfpApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # dfp.logger = Logger.new('dfp_xml.log')

  master_creative_id = 'INSERT_MASTER_CREATIVE_ID_HERE'.to_i

  # Get the CreativeSetService.
  creative_set_service = dfp.service(:CreativeSetService, API_VERSION)

  # Create a statement to get all creative sets that have the given master
  # creative.
  statement = DfpApi::FilterStatement.new(
      'WHERE masterCreativeId = :master_creative_id ORDER BY id ASC',
      [
          {:key => 'master_creative_id',
           :value => {:value => master_creative_id, :xsi_type => 'NumberValue'}}
      ]
  )

  begin
    # Get creative sets by statement.
    page = creative_set_service.get_creative_sets_by_statement(
        statement.toStatement())

    if page and page[:results]
      page[:results].each_with_index do |creative_set, index|
        puts ('%d) Creative set ID: %d, master creative ID: %d and companion ' +
            'creative IDs: [%s]') %
            [index + statement.offset, creative_set[:id],
             creative_set[:master_creative_id],
             creative_set[:companion_creative_ids].join(', ')]
      end
    end
    statement.offset += DfpApi::SUGGESTED_PAGE_LIMIT
  end while statement.offset < page[:total_result_set_size]

  # Print a footer.
  if page.include?(:total_result_set_size)
    puts 'Number of results found: %d' % page[:total_result_set_size]
  end
end

if __FILE__ == $0
  begin
    get_creative_sets_by_statement()

  # HTTP errors.
  rescue AdsCommon::Errors::HttpError => e
    puts "HTTP Error: %s" % e

  # API errors.
  rescue DfpApi::Errors::ApiException => e
    puts "Message: %s" % e.message
    puts 'Errors:'
    e.errors.each_with_index do |error, index|
      puts "\tError [%d]:" % (index + 1)
      error.each do |field, value|
        puts "\t\t%s: %s" % [field, value]
      end
    end
  end
end

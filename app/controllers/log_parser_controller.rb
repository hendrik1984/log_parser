class LogParserController < ApplicationController
  require 'log_parser_custom'

  def index
    @raw_data = Log.last
    @search = params["search"]
    @result_parses = []

    if @raw_data
      if @raw_data.file && params["search"] != nil
        @result_parses = LogParserCustom.parser(@raw_data, params["search"])
      else
        render status: :unprocessable_entity
      end
    end
  end
end

class LogParserController < ApplicationController
  require 'log_parser_custom'

  def index
    @raw_data       = Log.last
    @search         = params["search"]
    @result_parses  = []

    if @raw_data.present? && @raw_data.file && @search != nil
      @validator = LogParserParams.new(@search)
      if !@validator.valid?
        redirect_to root_path, notice: "There is an error(s): #{@validator.errors.messages}"
      end

      @result_parses = LogParserCustom.parser(@raw_data, @search)
    end
  end

end

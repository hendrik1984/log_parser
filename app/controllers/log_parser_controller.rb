class LogParserController < ApplicationController
  require 'log_parser_custom'

  def index
    @raw_data = Log.last
    @search = params["search"]
    @result_parses = []

    if @raw_data.file && params["search"] != nil
      # TODO: create beautiful method path, this is ugly
      path_blob = ActiveStorage::Blob.service.path_for(@raw_data.file.key)

      # TODO create method to read file
      apache_regex = /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}) - (.{0})- \[([^\]]+?)\] "(GET|POST|PUT|DELETE) ([^\s]+?) (HTTP\/1\.1)" (\d+) (\d+) ([^\s]+?) "(.*)"/

      file = File.foreach(path_blob)
      file.each_entry do |line|
        parser = line.scan(apache_regex)[0]

        if line.scan(apache_regex)[0].nil?
          puts "Can't parser: #{line}\n\n"
          next
        end

        parse = {
          :ip         => parser[0],
          :user       => parser[1],
          :time       => parser[2],
          :method     => parser[3],
          :uri_path   => parser[4],
          :protocol   => parser[5],
          :code       => parser[6],
          :res_size   => parser[7],
          :referer    => parser[8],
          :user_agent => parser[9]
        }

        @result_parses << parse if LogParserCustom.search(parse, params[:search])
      end
    else
      render status: :unprocessable_entity
    end
  end
end

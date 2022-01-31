class LogParserParams
    include ActiveModel::Validations

    attr_reader :ip, :method, :code, :start_time, :end_time, :uri_path, :user_agent

    def initialize(params)
      @ip           = params[:ip]
      @method       = params[:method]
      @code         = params[:code]
      @start_time   = params[:start_time]
      @end_time     = params[:end_time]
      @uri_path     = params[:uri_path]
      @user_agent   = params[:user_agent]
    end

    # validations
    validates :method, inclusion: {in: %w(GET POST), message: "%{value} is should GET or POST method"}
    validates :code, numericality: true, allow_blank: true

end

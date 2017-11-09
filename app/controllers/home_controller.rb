class HomeController < ApplicationController

  def index
  end

  def input
    @response = {}
    @content = params[:content]
    @ex = params[:extension]
    @name = SecureRandom.hex(2)
    @input = InputFile.new(@name,@content,@ex)
    @input.createFile
    @input.execute
    @response["response"] = @input.respond
    respond_to do |format|
      format.json { render json: @response}
    end
    FileDeleteJob.perform_later @name
  end

  # def clear
  #   @response = {}
  #   @file = params[:name]
  #   FileDeleteJob.perform_later @file
  #   @response["response"] = "success"
  #   respond_to do |format|
  #     format.json { render json: @response}
  #   end
  # end

  # def check_cache
  #   @response = {}
  #   @uid = params[:uid]
  #   @aid = params[:aid]
  #   @lang = params[:language]
  #   @obj = Check.new(@uid,@aid,@lang)
  #   @response["response"] = @obj.has_cache
  #   respond_to do |format|
  #     format.json { render json: @response}
  #   end
  # end

end
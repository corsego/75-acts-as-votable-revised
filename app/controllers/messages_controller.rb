class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy upvote downvote vote bookmark ]

  def index
    # @messages = Message.all
    @messages = Message.order(cached_weighted_like_score: :desc)
  end
  
  def bookmark
    @message.bookmark!(current_user)
    respond_to do |format|
      format.html do
        redirect_to @message
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@message, partial: "messages/message", locals: {message: @message})
      end
    end
  end
  
  def vote
    case params[:type]
    when 'upvote'
      @message.upvote!(current_user)
    when 'downvote'
     @message.downvote!(current_user)
    else
      return redirect_to request.url, alert: "no such vote type"
    end
    respond_to do |format|
      format.html do
        redirect_to @message
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@message, partial: "messages/message", locals: {message: @message})
      end
    end
  end
  
  def upvote
    @message.upvote!(current_user)
    respond_to do |format|
      format.html do
        redirect_to @message
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@message, partial: "messages/message", locals: {message: @message})
      end
    end
  end

  def downvote
    @message.downvote!(current_user)
    respond_to do |format|
      format.html do
        redirect_to @message
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@message, partial: "messages/message", locals: {message: @message})
      end
    end
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to message_url(@message), notice: "Message was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:body)
    end
end

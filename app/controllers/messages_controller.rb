class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.by_user_received(current_user.id).not_archive.order(date_send: :DESC)
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @messages = Message.set_read(params)
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  def archive
    message_id = params[:id]
    @message = Message.archive(message_id)

    respond_to do |format|
      if !@message.nil?
        format.html { redirect_to messages_url notice: 'Mensagens arquivadas com sucesso' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive_all
    @messages = Message.by_user_received(current_user.id).not_archive
    Message.archive_all(@messages)

    respond_to do |format|
      if !@messages.nil?
        format.html { redirect_to messages_url notice: 'Mensagem arquivadas com sucesso' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.create_message(message_params,current_user)

    respond_to do |format|
      if !@message.nil?
        format.html { redirect_to messages_url notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:send, :read, :date_send, :date_read, :text, :user_id, :user_send_id, :user_received_id)
    end
end

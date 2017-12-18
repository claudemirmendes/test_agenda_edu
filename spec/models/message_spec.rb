require 'rails_helper'
require 'factory_girl_rails'

RSpec.describe Message, :type => :model do
  describe "#create_message" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:user_received) { FactoryGirl.create(:user,email: "master@teste.com") }

    context "creating message" do
      let(:message_params) do
        {
          text: "teste de texto",
          user_received_id: "master@teste.com"
        }
      end

      it "create one message" do
        Message.create_message(message_params,user)
        byebug
        message = Message.where(user_received_id: user_received.id)

        expect(message.size).to be(1)
      end
    end
  end
end
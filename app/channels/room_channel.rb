# frozen_string_literal: true

# Room Channel
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "RoomChannel_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

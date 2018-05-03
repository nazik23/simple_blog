class NotifyChannel < ApplicationCable::Channel
  def subscribed
	  stream_from "posts"
		stream_from "comments"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

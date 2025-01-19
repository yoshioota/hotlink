# frozen_string_literal: true

class BookmarkChannel < ApplicationCable::Channel
  BROADCASTING_NAME = 'BookmarkChannel'

  TYPE_SAVED = 'type_saved'

  def subscribed
    stream_from(BROADCASTING_NAME)
  end

  def unsubscribed
  end

  class Broadcaster
    # NOTE: とりあえず保存したという通知だけwebsocketで飛ばして
    # frontで正規APIにて取得してもらうことを想定
    def self.saved
      ActionCable.server.broadcast(
        BROADCASTING_NAME,
        {
          type: TYPE_SAVED
        }
      )
    end
  end
end

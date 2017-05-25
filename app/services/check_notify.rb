require 'thread'
# check notifications
module CheckNotify
  NUM_THREADS = 4
  Thread.abort_on_exception = true
  class << self

    def check!
      # find the latest record with notification_id
      query = "select r.* from record r INNER JOIN (select notification_id, max(created_at) as t from record group by notification_id) rr on r.notification_id = rr.notification_id and r.created_at = rr.created_at"
      sent_record = ActiveRecord::Base.connection.execute(query)
      # find notify haven't taken medicine'
      notifies = Notification.where("wday = ? and taken_medicine = false", "#{Date.today.strftime('%A')}")

      threads = Array.new(NUM_THREADS) do
        Thread.new do
          notifies.each do |notify|
            record = sent_record.select{ |r| r.notification_id == notify.id }
            # (none record) or (record exists but not today's')
            if !record || record.created_at.strftime('%A') != notify.wday
              push_notifications(notify)
              notify.update(taken_medicine: true)
            end
          end
        end # Thread
      end # threads
      threads.each(&:join)
    end

    def push_notifications(notify)
      tokens = [
        notify.medicine_time,
        notify.medicine_pill_num
      ]
      password = nil
      notification = RubyPushNotifications::APNS::APNSNotification.new tokens, { aps: { alert: 'Time for medicine!', sound: 'true', badge: 1 } }

      pusher = RubyPushNotifications::APNS::APNSPusher.new(File.read('/path/to/your/apps/certificate.pem'), true, password)
      pusher.push [notification]
      p 'Notification sending results:'
      p "Success: #{notification.success}, Failed: #{notification.failed}"
      p 'Details:'
      p notification.individual_results
    end
  end # class

end

require 'thread'

NUM_THREADS = 4
Thread.abort_on_exception = true

def check
  threads = []
  # 找出每筆吃藥時間的最新一筆
  query = "select r.* from record r INNER JOIN (select notification_id, max(created_at) as t from record group by notification_id) rr on r.notification_id = rr.notification_id and r.created_at = rr.created_at"
  sent_record = ActiveRecord::Base.connection.execute(query)
  # 找出今日尚未吃藥
  notifies = Notification.where("wday = ? and taken_medicine = false", "#{Date.today.strftime('%A')}")

  threads << Thread.start do
    notifies.each do |notify|
      record = sent_record.select{ |r| r.notification_id == notify.id }
      # 沒有紀錄 有紀錄但是日期不同
      if !record || record.created_at.strftime('%A') != notify.wday
        push_notifications(notify)
        notify.update(taken_medicine: true)
      end
    end
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
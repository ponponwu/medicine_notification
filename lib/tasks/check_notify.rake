namespace :check_notify do
  task execute_check: :environment do
    desc 'check if taken medicine'
    CheckNotify.new.check!
  end
end

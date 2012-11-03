namespace :mquc do
  task :toggle_admin, [:user_id] => [:environment] do |t, args|
    user = User.find args.user_id
    puts "User: #{user.name}"
    user.update_attribute(:admin, !user.admin)
    puts "Admin: #{user.admin?}"
  end
end

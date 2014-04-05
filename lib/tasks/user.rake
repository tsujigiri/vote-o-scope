namespace :user do
  desc 'Add a user'
  task :add, [:email, :password] => :environment do |_, args|
    User.create(email: args.email, password: args.password,
                password_confirmation: args.password)
  end
end

namespace :dev do
  
  DEFAULT_PASSWORD = 123456
  
  desc "Configures the development environment"
  task setup: :environment do
    if Rails.env.development?
      
      plot_with_load('Deleting Database') { %x(rails db:drop) }
      plot_with_load('Creating Database') { %x(rails db:create) }
      plot_with_load('Migrating Tables') { %x(rails db:migrate) }
      plot_with_load('Adding Default Admin') { %x(rails dev:add_default_admin) }
      plot_with_load('Adding Extra Admins') { %x(rails dev:add_extra_admins) }
      plot_with_load('Adding Default User') { %x(rails dev:add_default_user) }
      # %x(rails dev:add_mining_types)
      # %x(rails dev:add_coins)

    else
      puts "You don't are in development environment"
    end
  end
  
  desc "Add an admin default"
  task add_default_admin: :environment do
    Admin.create!(
        email: 'admin@admin.com',
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
  end
  
  desc "Adds others admins extra"
  task add_extra_admins: :environment do
    10.times do |i|
      Admin.create!(
          email: Faker::Internet.email,
          password: DEFAULT_PASSWORD,
          password_confirmation: DEFAULT_PASSWORD
        )
    end
  end
  
  desc "Add an user default"
  task add_default_user: :environment do
    User.create!(
        email: 'user@user.com',
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
  end
  
  private
    def plot_with_load(messenge_entry, messenge_out=' (Done!)')
    
      spinner = TTY::Spinner.new("[:spinner] #{messenge_entry} ...", format: :pong)
      spinner.auto_spin
      yield
      spinner.success("#{messenge_out}")
    
    end

end

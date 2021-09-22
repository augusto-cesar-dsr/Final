namespace :dev do
  
  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configures the development environment"
  task setup: :environment do
    if Rails.env.development?
      
      plot_with_load('Deleting Database') { %x(rails db:drop) }
      plot_with_load('Creating Database') { %x(rails db:create) }
      plot_with_load('Migrating Tables') { %x(rails db:migrate) }
      plot_with_load('Adding Default Admin') { %x(rails dev:add_default_admin) }
      plot_with_load('Adding Extra Admins') { %x(rails dev:add_extra_admins) }
      plot_with_load('Adding Default User') { %x(rails dev:add_default_user) }
      plot_with_load('Adding Default Subjects') {%x(rails dev:add_subjects)}
      plot_with_load('Adding Some Questions and Answers') {%x{rails dev:add_answers_and_questions}}

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
  
  desc "Add default subjects"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)
    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end
  
  desc "Add questions and answers"
  task add_answers_and_questions: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do |i|
        Question.create!(
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
          subject: subject
        )
      end
    end
  end

  private

    def plot_with_load(messenge_entry, messenge_out=' (Done!)')
      spinner = TTY::Spinner.new("[:spinner] #{messenge_entry} ...", format: :pong)
      spinner.auto_spin
      yield
      spinner.success("#{messenge_out}")
    end

end

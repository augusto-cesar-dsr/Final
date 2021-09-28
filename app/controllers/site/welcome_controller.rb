class Site::WelcomeController < SiteController
  def index
    @questions = Question.all
  end
end

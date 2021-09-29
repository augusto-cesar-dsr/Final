module SiteHelper
  def msg_system
    case params[:action]
    when 'index'
      "Last questions..."
    when 'questions'
      "Results for the term \"#{params[:term]}\"..."
    when 'subject'
      "Show questions for the subject \"#{params[:subject_id]}\"..."
    end
  end
end

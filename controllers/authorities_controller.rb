class AuthoritiesController < Sinatra::Base

  # sets the root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @authorities = Authority.all
    erb :'index'
  end

  get '/:id' do
    id = params[:id].to_i
    redirect '/' if id < 1 || id > 408
    authority = Authority.find(id.to_s)
    @authority_name = authority.shift
    est_total = authority.shift
    @establishment_count = est_total
    if authority.count("Pass") > 0
      @ratings = ["Pass", "Pass and Eat Safe", "Improvement Required", "Exempt"]
    else
      @ratings = ["5", "4", "3", "2", "1", "Exempt"]
    end
    @ratios = @ratings.map { |rating| ((authority.count(rating).to_f/est_total.to_f).round(3)*100).to_s[0..3].to_f if authority.count(rating) != 0 }
    erb :'show'
  end
  
end
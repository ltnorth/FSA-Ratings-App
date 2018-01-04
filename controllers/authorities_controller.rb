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
    id = params[:id]
    authority = Authority.find(id)
    @authority_name = authority.shift
    est_total = authority.shift
    @establishment_count = est_total
    if authority.count("Pass") > 0
      @ratings = ["Pass", "Pass and Eat Safe", "Improvement Required", "Exempt"]
      @ratios = @ratings.map { |rating| (authority.count(rating) / est_total.to_i) if authority.count(rating) != 0}
    else
      @ratings = ["5", "4", "3", "2", "1", "Exempt"]
      @ratios = @ratings.map { |rating| (authority.count(rating) / est_total.to_i) if authority.count(rating) != 0}
    end
    erb :'show'
  end
  
end
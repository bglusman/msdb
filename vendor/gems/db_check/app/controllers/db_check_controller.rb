class DbCheckController < ApplicationController
  def index
  end

  def show
    if DbChecker.singleton_methods(false).include? params[:check_type]
      @results, @template = DbChecker.send(params[:check_type])
    else raise NoMethodError
    end
  end

end

class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @attempts = current_user.attempts
    end
  end

  def about
  end

  def contact
  end

  def jacob
  end
end

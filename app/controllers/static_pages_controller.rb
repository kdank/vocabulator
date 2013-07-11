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

  def coursework
    @fall_2006 = Course::FALL_2006
    @spring_2007 = Course::SPRING_2007
    #@fall_2007 = Course::FALL_2007
    #@spring_2008 = Course::SPRING_2008
    #@fall_2008 = Course::FALL_2008
    #@spring_2009 = Course::SPRING_2009
    #@fall_2009 = Course::FALL_2009
    #@spring_2010 = Course::SPRING_2010
  end
end

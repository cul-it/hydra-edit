# Generated via
#  `rails generate curation_concerns:work Book`

class CurationConcerns::BooksController < ApplicationController
  include CurationConcerns::CurationConcernController
  set_curation_concern_type Book


    # Gives the class of the show presenter. Override this if you want
  # to use a different presenter.
  def show_presenter
    # CurationConcerns::WorkShowPresenter
    ::BookPresenter
  end

  
end

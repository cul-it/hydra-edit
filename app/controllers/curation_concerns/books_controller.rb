# Generated via
#  `rails generate curation_concerns:work Book`

module CurationConcerns
  class BooksController < ApplicationController
    include CurationConcerns::CurationConcernController
    self.curation_concern_type = Book
  end
end

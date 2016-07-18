# Generated via
#  `rails generate curation_concerns:work Page`

module CurationConcerns
  class PagesController < ApplicationController
    include CurationConcerns::CurationConcernController
    self.curation_concern_type = Page
  end
end

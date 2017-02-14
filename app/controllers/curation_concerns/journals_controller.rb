# Generated via
#  `rails generate curation_concerns:work Journal`

module CurationConcerns
  class JournalsController < ApplicationController
    include CurationConcerns::CurationConcernController
    self.curation_concern_type = Journal
  end
end

# Generated via
#  `rails generate curation_concerns:work Issue`

module CurationConcerns
  class IssuesController < ApplicationController
    include CurationConcerns::CurationConcernController
    self.curation_concern_type = Issue
  end
end

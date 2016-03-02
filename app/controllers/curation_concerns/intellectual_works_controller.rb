# Generated via
#  `rails generate curation_concerns:work IntellectualWork`

class CurationConcerns::IntellectualWorksController < ApplicationController
  include CurationConcerns::CurationConcernController
  set_curation_concern_type IntellectualWork
end

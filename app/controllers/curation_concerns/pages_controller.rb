# Generated via
#  `rails generate curation_concerns:work Page`

class CurationConcerns::PagesController < ApplicationController
  include CurationConcerns::CurationConcernController
  set_curation_concern_type Page
end

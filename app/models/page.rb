# Generated via
#  `rails generate curation_concerns:work Page`
class Page < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::CurationConcerns::BasicMetadata
  validates :title, presence: { message: 'Your work must have a title.' }
  
  
  
end

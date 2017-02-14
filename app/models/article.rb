# Generated via
#  `rails generate curation_concerns:work Issue`
class Article < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::BasicMetadata
  include ::RequiredMetadata

  validates :title, presence: { message: 'Your work must have a title.' }



end

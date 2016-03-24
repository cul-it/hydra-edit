# Generated via
#  `rails generate curation_concerns:work Page`
class Page < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::BasicMetadata
  validates :title, presence: { message: 'Your work must have a title.' }
  
  property :our_identifier, predicate: ::RDF::URI("http://purl.org/dc/terms/identifier") do |index|
       index.as :stored_searchable
  end
  
  
end

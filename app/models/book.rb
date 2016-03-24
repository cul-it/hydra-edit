# Generated via
#  `rails generate curation_concerns:work Book`
class Book < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::BasicMetadata
  include ::RequiredMetadata
  validates :title, presence: { message: 'Your work must have a title.' }
  
  property :alternative_title, predicate: ::RDF::URI("http://purl.org/dc/term/alternative") do |index| 
       index.as :stored_searchable
   end
## collection property should automagically be a part of this object
  property :compiler, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P50189") do |index|
       index.as :stored_searchable
  end
  property :editor, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P60393") do |index|
       index.as :stored_searchable
  end
  property :translator, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P60613") do |index|
       index.as :stored_searchable
  end
  property :extent, predicate: ::RDF::URI("http://purl.org/dc/terms/extent") do |index|
       index.as :stored_searchable
  end
  property :format, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/format") do |index|
       index.as :stored_searchable
  end
  property :format_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/format") do |index|
       index.as :stored_searchable
  end
  property :our_identifier, predicate: ::RDF::URI("http://purl.org/dc/terms/identifier") do |index|
       index.as :stored_searchable
  end
  property :repository_location, predicate: ::RDF::URI("http://www.europeana.eu/schemas/edm/currentLocation") do |index|
       index.as :stored_searchable
  end
  property :item_type, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/type") do |index|
       index.as :stored_searchable
  end
  property :item_type_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/type") do |index|
       index.as :stored_searchable
  end
#    
  
end

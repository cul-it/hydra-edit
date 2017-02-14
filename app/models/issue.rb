# Generated via
#  `rails generate curation_concerns:work Issue`
class Issue < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::BasicMetadata
  include ::RequiredMetadata

  validates :title, presence: { message: 'Your work must have a title.' }
    
  property :alternative_title, predicate: ::RDF::URI("http://purl.org/dc/terms/alternative") do |index|
       index.as :stored_searchable
   end
  property :date, predicate: ::RDF::URI("http://purl.org/dc/terms/date") do |index|
       index.as :stored_searchable
  end
  property :copyrightDate, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P60069") do |index|
       index.as :stored_searchable
  end
  property :edition, predicate: ::RDF::URI("http://purl.org/bibo/edition") do |index|
       index.as :stored_searchable
  end
    property :editor, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P60393") do |index|
       index.as :stored_searchable
  end
  property :issuingBody, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P60374") do |index|
       index.as :stored_searchable
  end
  property :extent, predicate: ::RDF::URI("http://purl.org/dc/terms/extent") do |index|
       index.as :stored_searchable
  end
  property :repository, predicate: ::RDF::URI("http://www.europeana.eu/schemas/edm/currentLocation") do |index|
       index.as :stored_searchable
  end
  property :issue_type, predicate: ::RDF::URI("http://purl.org/dc/type") do |index|
       index.as :stored_searchable
  end
  property :issue_type_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/type") do |index|
       index.as :stored_searchable
  end
  property :edition, predicate: ::RDF::URI("http://purl.org/bibo/edition") do |index|
       index.as :stored_searchable
  end
  property :physicalSource, predicate: ::RDF::URI("http://purl.org/dc/terms/source") do |index|
       index.as :stored_searchable
  end
  property :placeOfPublication, predicate: ::RDF::URI("http://vivoweb.org/ontology/core/placeOfPublication") do |index|
       index.as :stored_searchable
  end


end

# Generated via
#  `rails generate curation_concerns:work Page`
class Page < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::BasicMetadata
  include ::RequiredMetadata

  validates :title, presence: { message: 'Your work must have a title.' }

  property :our_identifier, predicate: ::RDF::URI("http://purl.org/dc/terms/identifier") do |index|
       index.as :stored_searchable
  end
  property :heading, predicate: ::RDF::URI("http://opaquenamespace.org/terms/heading") do |index|
       index.as :stored_searchable
  end
  property :node, predicate: ::RDF::URI("http://opaquenamespace.org/terms/node") do |index|
       index.as :stored_searchable
  end
  property :node_type, predicate: ::RDF::URI("http://opaquenamespace.org/terms/node_type") do |index|
       index.as :stored_searchable
  end
  property :page_number, predicate: ::RDF::URI("http://opaquenamespace.org/terms/page_number") do |index|
       index.as :stored_searchable
  end

end

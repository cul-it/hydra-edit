class Collection < ActiveFedora::Base
  include Hydra::Works::CollectionBehavior
  
#  has_many :books
#  has_many :bibliographic_works
  contains "collectionThumbnail"
  
  property :collection_title, predicate: ::RDF::Vocab::DC11.title, multiple: false do |index|
    index.as :stored_searchable
  end
  property :collection_abstract, predicate: ::RDF::URI("http://purl.org/dc/terms/abstract"), multiple: false do |index|
    index.as :stored_searchable
  end
  property :collection_date, predicate: ::RDF::URI("http://purl.org/dc/terms/created"), multiple: false do |index|
    index.as :stored_searchable
  end
  property :collection_bibid, predicate: ::RDF::Vocab::DC11.identifier, multiple: false do |index|
    index.as :stored_searchable
  end
  property :collection_note, predicate: ::RDF::Vocab::DC11.description, multiple: false do |index|
    index.as :stored_searchable
  end
  property :collection_publ, predicate: ::RDF::Vocab::DC11.publisher, multiple: false do |index|
    index.as :stored_searchable
  end
  property :collection_publ_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/publisher"), multiple: false do |index|
    index.as :stored_searchable
  end
  property :collection_relatedURL, predicate: ::RDF::Vocab::DC11.relation, multiple: false do |index|
    index.as :stored_searchable
  end
  property :repository_location, predicate: ::RDF::URI("http://www.europeana.eu/schemas/edm/currentLocation"), multiple: false do |index|
       index.as :stored_searchable
  end
  
end
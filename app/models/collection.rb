# Generated by curation_concerns:models:install
class Collection < ActiveFedora::Base
  include ::CurationConcerns::CollectionBehavior
  #This is a PCDM Collection Object
  
  property :abstract, predicate: ::RDF::URI("http://purl.org/dc/terms/abstract"), multiple: false do |index|
    index.as :stored_searchable
  end
  property :bibid, predicate: ::RDF::Vocab::DC11.identifier, multiple: false do |index|
    index.as :stored_searchable
  end
  property :relatedURL, predicate: ::RDF::Vocab::DC11.relation, multiple: false do |index|
    index.as :stored_searchable
  end

end

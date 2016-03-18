module CurationConcerns
  module BasicMetadata
    extend ActiveSupport::Concern

    included do
      property :label, predicate: ActiveFedora::RDF::Fcrepo::Model.downloadFilename, multiple: false

      property :relative_path, predicate: ::RDF::URI.new('http://scholarsphere.psu.edu/ns#relativePath'), multiple: false

      property :import_url, predicate: ::RDF::URI.new('http://scholarsphere.psu.edu/ns#importUrl'), multiple: false do |index|
        index.as :symbol
      end

      property :part_of, predicate: ::RDF::Vocab::DC.isPartOf
      property :resource_type, predicate: ::RDF::Vocab::DC.type do |index|
        index.as :stored_searchable, :facetable
      end
      property :creator, predicate: ::RDF::Vocab::DC11.creator do |index|
        index.as :stored_searchable, :facetable
      end
      property :contributor, predicate: ::RDF::Vocab::DC11.contributor do |index|
        index.as :stored_searchable, :facetable
      end
      property :contributor_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/contributor"), multiple: false do |index| 
         index.as :stored_searchable
      end
      property :creator_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/creator"), multiple: false do |index| 
          index.as :stored_searchable
      end
      property :note, predicate: ::RDF::URI("http://purl.org/dc/terms/description"), multiple: false do |index|
         index.as :stored_searchable
      end
      property :abstract, predicate: ::RDF::URI("http://purl.org/dc/terms/abstract"), multiple: false do |index| 
         index.as :stored_searchable
      end
      property :tag, predicate: ::RDF::Vocab::DC11.relation do |index|
        index.as :stored_searchable, :facetable
      end
      property :rights, predicate: ::RDF::Vocab::DC.rights do |index|
        index.as :stored_searchable
      end
      property :publisher, predicate: ::RDF::Vocab::DC11.publisher do |index|
        index.as :stored_searchable, :facetable
      end
      property :publisher_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/publisher"), multiple: false do |index|
        index.as :stored_searchable
     end
     property :date_created, predicate: ::RDF::Vocab::DC.created do |index|
        index.as :stored_searchable
      end
 ## Decide which field will hold range slider dates
 #     property :date, predicate: ::RDF::URI("http://purl.org/dc/terms/created"), multiple: false do |index|
 #       index.as :stored_searchable
 #     end
      property :subject, predicate: ::RDF::Vocab::DC11.subject do |index|
        index.as :stored_searchable, :facetable
      end
      property :language_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/language"), multiple: false do |index|
         index.as :stored_searchable
      end
      property :language, predicate: ::RDF::Vocab::DC11.language do |index|
         index.as :stored_searchable, :facetable
      end
      property :our_identifier, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/identifier"), multiple: true do |index|
        index.as :stored_searchable
      end
      property :based_near, predicate: ::RDF::Vocab::FOAF.based_near do |index|
         index.as :stored_searchable, :facetable
      end
      property :related_url, predicate: ::RDF::RDFS.seeAlso do |index|
         index.as :stored_searchable
      end
      property :bibliographic_citation, predicate: ::RDF::Vocab::DC.bibliographicCitation do |index|
         index.as :stored_searchable
      end
      property :source, predicate: ::RDF::Vocab::DC.source do |index|
         index.as :stored_searchable
      end
#      property :ocr, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/relation"), multiple: false do |index|
#         index.as :searchable
#      end
      property :pubplace, predicate: ::RDF::URI("http://vivoweb.org/ontology/core#placeOfPublication"), multiple: false do |index|
         index.as :stored_searchable
      end
      property :rights, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/rights"), multiple: false do |index|
         index.as :stored_searchable
      end
      property :rights_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/rights"), multiple: false do |index|
         index.as :stored_searchable
      end
      property :rightsHolder, predicate: ::RDF::URI("http://purl.org/dc/terms/rightsHolder"), multiple: false do |index|
         index.as :stored_searchable
      end
      property :subject, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/subject"), multiple: true do |index|
         index.as :stored_searchable
      end
      property :subject_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/subject"), multiple: false do |index|
         index.as :stored_searchable
      end
      
    end
  end
end

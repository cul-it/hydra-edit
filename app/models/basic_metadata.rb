#module CurationConcerns
  module BasicMetadata
    extend ActiveSupport::Concern

    included do
      property :label, predicate: ActiveFedora::RDF::Fcrepo::Model.downloadFilename

      property :relative_path, predicate: ::RDF::URI.new('http://scholarsphere.psu.edu/ns#relativePath')

      property :import_url, predicate: ::RDF::URI.new('http://scholarsphere.psu.edu/ns#importUrl') do |index|
        index.as :symbol
      end

 #     property :part_of, predicate: ::RDF::Vocab::DC.isPartOf
      property :resource_type, predicate: ::RDF::Vocab::DC.type do |index|
        index.as :stored_searchable, :facetable
      end
      property :creator, predicate: ::RDF::Vocab::DC11.creator do |index|
        index.as :stored_searchable, :facetable
      end
      property :contributor, predicate: ::RDF::Vocab::DC11.contributor do |index|
        index.as :stored_searchable, :facetable
      end
      property :contributor_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/contributor") do |index| 
         index.as :stored_searchable
      end
      property :creator_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/creator") do |index| 
          index.as :stored_searchable
      end
      property :note, predicate: ::RDF::URI("http://purl.org/dc/terms/description") do |index|
         index.as :stored_searchable
      end
      property :abstract, predicate: ::RDF::URI("http://purl.org/dc/terms/abstract") do |index| 
         index.as :stored_searchable
      end
      property :tag, predicate: ::RDF::Vocab::DC11.relation do |index|
        index.as :stored_searchable, :facetable
      end
      
# rights is repeated below
#      property :rights, predicate: ::RDF::Vocab::DC.rights do |index|
#        index.as :stored_searchable
#      end


      property :publisher, predicate: ::RDF::Vocab::DC11.publisher do |index|
        index.as :stored_searchable, :facetable
      end
      property :publisher_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/publisher") do |index|
        index.as :stored_searchable
     end
     property :date_created, predicate: ::RDF::Vocab::DC.created, multiple: false do |index|
        index.as :stored_searchable
      end
 ## Decide which field will hold range slider dates
 #     property :date, predicate: ::RDF::URI("http://purl.org/dc/terms/created") do |index|
 #       index.as :stored_searchable
 #     end
      #repeated below
      #property :subject, predicate: ::RDF::Vocab::DC11.subject do |index|
      #  index.as :stored_searchable, :facetable
      # end
      property :language_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/language") do |index|
         index.as :stored_searchable
      end
      property :language, predicate: ::RDF::Vocab::DC11.language do |index|
         index.as :stored_searchable, :facetable
      end
      property :identifier, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/identifier") do |index|
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
      property :ocr, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/relation") do |index|
         index.as :searchable
      end
      property :pubplace, predicate: ::RDF::URI("http://vivoweb.org/ontology/core#placeOfPublication") do |index|
         index.as :stored_searchable
      end
      property :rights, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/rights") do |index|
         index.as :stored_searchable
      end
      property :rights_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/rights") do |index|
         index.as :stored_searchable
      end
      property :rightsHolder, predicate: ::RDF::URI("http://purl.org/dc/terms/rightsHolder") do |index|
         index.as :stored_searchable
      end
      property :subject, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/subject") do |index|
         index.as :stored_searchable
      end
      property :subject_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/subject") do |index|
         index.as :stored_searchable
      end
      
    end
  end
#end

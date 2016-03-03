# Generated by curation_concerns:models:install
class FileSet < ActiveFedora::Base
  include ::CurationConcerns::FileSetBehavior

      property :fileset_title, predicate: ::RDF::URI("http://purl.org/dc/terms/title"), multiple: false do |index|
        index.as :stored_searchable, :facetable
      end  
      property :fileset_extent, predicate: ::RDF::URI("http://purl.org/dc/terms/extent"), multiple: false do |index|
         index.as :stored_searchable
      end
      property :fileset_identifier, predicate: ::RDF::Vocab::DC.identifier do |index|
        index.as :stored_searchable
      end
      property :fileset_note, predicate: ::RDF::URI("http://purl.org/dc/terms/description"), multiple: false do |index|
         index.as :stored_searchable
      end
      property :fileset_rights, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/rights"), multiple: false do |index|
         index.as :stored_searchable
      end
      property :fileset_rights_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/rights"), multiple: false do |index|
         index.as :stored_searchable
      end
      property :fileset_rightsHolder, predicate: ::RDF::URI("http://purl.org/dc/terms/rightsHolder"), multiple: false do |index|
         index.as :stored_searchable
      end
      property :mimetype, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/format"), multiple: false do |index|
         index.as :stored_searchable
      end
  
  
end
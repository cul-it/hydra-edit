# Generated by curation_concerns:models:install
class FileSet < ActiveFedora::Base
  include ::CurationConcerns::FileSetBehavior

      property :fileset_title, predicate: ::RDF::URI("http://purl.org/dc/terms/title") do |index|
        index.as :stored_searchable, :facetable
      end  
      property :fileset_extent, predicate: ::RDF::URI("http://purl.org/dc/terms/extent") do |index|
         index.as :stored_searchable
      end
      property :fileset_identifier, predicate: ::RDF::Vocab::DC.identifier do |index|
        index.as :stored_searchable
      end
      property :fileset_note, predicate: ::RDF::URI("http://purl.org/dc/terms/description") do |index|
         index.as :stored_searchable
      end
      property :fileset_rights, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/rights") do |index|
         index.as :stored_searchable
      end
      property :fileset_rights_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/rights")  do |index|
         index.as :stored_searchable
      end
      property :fileset_rightsHolder, predicate: ::RDF::URI("http://purl.org/dc/terms/rightsHolder")  do |index|
         index.as :stored_searchable
      end
      property :mimetype, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/format")  do |index|
         index.as :stored_searchable
      end
      property :awsimage, predicate: ::RDF::URI("http://www.europeana.eu/schemas/edm/hasView") do |index|
        index.as :stored_searchable
      end
      property :awsthumbnail, predicate: ::RDF::URI("http://www.europeana.eu/schemas/edm/preview") do |index|
        index.as :stored_searchable
      end
      property :image_width, predicate: ::RDF::URI("http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#width") do |index|
        index.as :stored_searchable
      end
      property :image_height, predicate: ::RDF::URI("http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#height") do |index|
        index.as :stored_searchable
      end
      property :image_filename, predicate: ::RDF::URI("http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#filename") do |index|
        index.as :stored_searchable
      end
  
  
end

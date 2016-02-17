class Book < ActiveFedora::Base
  include Hydra::Works::WorkBehavior
  include Hydra::PCDM::ObjectBehavior
  
#  require "rdf/vocab"

  
   contains 'descMetadata', class_name: 'BookMetadata'
   contains 'bookImage'
   contains 'bookImageThumbnail'
#  configure type: RDF::URI.new('http://example.com')
#  belongs_to :collection, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf
#  has_many :pages

 
  property :abstract, predicate: ::RDF::URI("http://purl.org/dc/terms/abstract"), multiple: false do |index| 
       index.as :stored_searchable
   end
  property :alternative_title, predicate: ::RDF::URI("http://purl.org/dc/term/alternative"), multiple: false do |index| 
       index.as :stored_searchable
   end
  property :contributor, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/contributor"), multiple: false do |index| 
       index.as :stored_searchable
   end
  property :contributor_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/contributor"), multiple: false do |index| 
       index.as :stored_searchable
   end
  property :creator, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/creator"), multiple: false do |index| 
       index.as :stored_searchable
   end
  property :creator_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/creator"), multiple: false do |index| 
       index.as :stored_searchable
   end
  property :compiler, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P50189"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :editor, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P60393"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :translator, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P60613"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :date_created, predicate: ::RDF::URI("http://purl.org/dc/terms/created"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :note, predicate: ::RDF::URI("http://purl.org/dc/terms/description"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :intell_extent, predicate: ::RDF::URI("http://purl.org/dc/terms/extent"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :format, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/format"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :format_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/format"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :identifier, predicate: ::RDF::URI("http://purl.org/dc/terms/identifier"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :language, predicate: ::RDF::URI("http://purl.org/dc/terms/language"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :place_of_origin, predicate: ::RDF::URI("http://vivoweb.org/ontology/core#placeOfPublication"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :publisher, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/publisher"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :publisher_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/publisher"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :repository_name, predicate: ::RDF::URI("http://www.europeana.eu/schemas/edm/currentLocation"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :intell_rights, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/rights"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :intell_rights_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/rights"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :intell_rightsHolder, predicate: ::RDF::URI("http://purl.org/dc/terms/rightsHolder"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :subject, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/subject"), multiple: true do |index|
       index.as :stored_searchable
  end
  property :subject_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/subject"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :title, predicate: ::RDF::URI("http://purl.org/dc/terms/title"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :item_type, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/type"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :item_type_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/type"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :ocr, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/relation"), multiple: false do |index|
       index.as :searchable
  end
  property :collection, predicate: ::RDF::URI("http://purl.org/dc/terms/isPartOf"),  multiple: false do |index|
       index.as :stored_searchable
  end
  
  property :book_ocr, delegate_to: 'descMetadata', multiple: true do |index|
       index.as :searchable
  end
end


#  has_file_datastream :name=>'digitalImage', :type=>ActiveFedora::Datastream, :mimeType=>"image/jpeg", :controlGroup=>'M', :versionable=>false
#  has_file_datastream :name=>'thumbnailImage', :type=>ActiveFedora::Datastream, :mimeType=>'image/jpeg', :controlGroup=>'M', :versionable=>false
#  has_file_datastream :name=>'pdf', :type=>ActiveFedora::Datastream, :mimeType=>'application/pdf', :controlGroup=>'M', :versionable=>false


#  belongs_to :derivation, :property=>:has_derivatio#n

#  has_many :pages, :property=>:has_pages


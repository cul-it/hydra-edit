class Page < ActiveFedora::Base
  include Hydra::Works::FileSetBehavior
  include Hydra::PCDM::ObjectBehavior

#  contains 'descMetadata', class_name: 'BookMetadata'
#  configure type: RDF::URI.new('http://example.com')
#  belongs_to :collection, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf
#  has_many :pages

   contains 'descMetadata', class_name: 'PageMetadata'
   contains 'pageImage'
   contains 'pageImageThumbnail'
  
  property :page_number, predicate: ::RDF::URI.new('http://opaquenamespace.org/hydra/pageNumber'), multiple: false do |index|
       index.as :stored_searchable
       index.type :integer
  end
  property :digital_work_title, predicate: ::RDF::URI("http://purl.org/dc/terms/title"), multiple: false do |index| 
       index.as :stored_searchable
   end
  property :digital_work_rights_statement, predicate: ::RDF::URI.new("http://opaquenamespace.org/hydra/rightsStatement"), multiple: false do |index| 
       index.as :stored_searchable
   end
  property :digital_work_rights_holder, predicate: ::RDF::URI("http://purl.org/dc/terms/rightsHolder"), multiple: false do |index| 
       index.as :stored_searchable
   end
  property :digital_work_rights_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/rights"), multiple: false do |index| 
       index.as :stored_searchable
   end
  property :digital_work_note, predicate: ::RDF::URI("http://purl.org/dc/terms/description"), multiple: false do |index| 
       index.as :stored_searchable
   end
  property :digital_work_identifier, predicate: ::RDF::URI("http://purl.org/dc/terms/identifier"), multiple: false do |index| 
       index.as :stored_searchable
   end
  property :files_extent, predicate: ::RDF::URI("http://purl.org/dc/terms/extent"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :image_ocr, predicate: ::RDF::URI.new('http://opaquenamespace.org/hydra/pageText'), multiple: false do |index|
       index.as :searchable
  end
  property :node, delegate_to: 'descMetadata', multiple: false do |index|
       index.as :stored_searchable
  end
  property :node_type, delegate_to: 'descMetadata', multiple: false do |index|
       index.as :stored_searchable
  end
  property :head_text, delegate_to: 'descMetadata', multiple: false do |index|
       index.as :stored_searchable
  end
  

end


#  has_file_datastream :name=>'digitalImage', :type=>ActiveFedora::Datastream, :mimeType=>"image/jpeg", :controlGroup=>'M', :versionable=>false
#  has_file_datastream :name=>'thumbnailImage', :type=>ActiveFedora::Datastream, :mimeType=>'image/jpeg', :controlGroup=>'M', :versionable=>false
#  has_file_datastream :name=>'pdf', :type=>ActiveFedora::Datastream, :mimeType=>'application/pdf', :controlGroup=>'M', :versionable=>false


#  belongs_to :derivation, :property=>:has_derivatio#n

#  has_many :pages, :property=>:has_pages


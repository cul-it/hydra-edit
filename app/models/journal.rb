class Journal < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::BasicMetadata
  include ::RequiredMetadata

  validates :title, presence: { message: 'Your work must have a title.' }

  property :alternative_title, predicate: ::RDF::URI("http://purl.org/dc/terms/alternative") do |index|
       index.as :stored_searchable
   end
## collection property should automagically be a part of this object
  property :date, predicate: ::RDF::URI("http://purl.org/dc/terms/date") do |index|
       index.as :stored_searchable
  end
  property :format, predicate: ::RDF::URI("http://purl.org/dc/format") do |index|
       index.as :stored_searchable
  end
  property :format_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/format") do |index|
       index.as :stored_searchable
  end
  property :our_identifier, predicate: ::RDF::URI("http://purl.org/dc/terms/identifier") do |index|
       index.as :stored_searchable
  end
  property :physicalSource, predicate: ::RDF::URI("http://purl.org/dc/terms/source") do |index|
       index.as :stored_searchable
  end 
  property :journalType, predicate: ::RDF::URI("http://purl.org/dc/type") do |index|
       index.as :stored_searchable
  end 
  property :journalType_URI, predicate: ::RDF::URI("http://purl.org/dc/terms/type") do |index|
       index.as :stored_searchable
  end
  property :edition, predicate: ::RDF::URI("http://purl.org/bibo/edition") do |index|
       index.as :stored_searchable
  end
  property :compiler, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P60428") do |index|
       index.as :stored_searchable
  end
  property :editor, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P60393") do |index|
     index.as :stored_searchable
  end
  property :translator, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P60613") do |index|
     index.as :stored_searchable
  end


end
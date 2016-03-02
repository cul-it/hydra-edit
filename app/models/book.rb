# Generated via
#  `rails generate curation_concerns:work Book`
class Book < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::CurationConcerns::BasicMetadata
  validates :title, presence: { message: 'Your work must have a title.' }
  
  property :alternative_title, predicate: ::RDF::URI("http://purl.org/dc/term/alternative"), multiple: false do |index| 
       index.as :stored_searchable
   end
## collection property should automagically be a part of this object
  property :compiler, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P50189"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :editor, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P60393"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :translator, predicate: ::RDF::URI("http://rdaregistry.info/Elements/u/P60613"), multiple: false do |index|
       index.as :stored_searchable
  end
  property :extent, predicate: ::RDF::URI("http://purl.org/dc/terms/extent"), multiple: false do |index|
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
  property :book_ocr, predicate: ::RDF::URI("http://purl.org/dc/elements/1.1/relation"), multiple: false do |index|
       index.as :searchable
  end
  property :pubplace, predicate: ::RDF::URI("http://vivoweb.org/ontology/core#placeOfPublication"), multiple: false do |index|
       index.as :stored_searchable
  end
    
  
end

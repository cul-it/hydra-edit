class BookMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "DLPSTEXTCLASS")
#    t.titlestmt_titletype(index_as: :stored_searchable)
#    t.titlestmt_title(index_as: :stored_searchable)
#    t.titlestmt_author(index_as: :stored_searchable)
#    t.extent(index_as: :stored_searchable)
#    t.pubstmt_publisher(index_as: :stored_searchable)
#    t.pubstmt_pubplace(index_as: :stored_searchable)
#    t.pubstmt_idno_type(index_as: :stored_searchable)
#    t.pubstmt_idno(index_as: :stored_searchable)
#    t.availability(index_as: :stored_searchable)
#    t.bibl_titletype(index_as: :stored_searchable)
#    t.title(index_as: :stored_searchable)
#    t.author(index_as: :stored_searchable, type: :string)
#    t.publisher(index_as: :stored_searchable)
#    t.pubplace(index_as: :stored_searchable)
#    t.pubdate(index_as: :stored_searchable)
#    t.date(index_as: :stored_searchable)
#    t.note(index_as: :stored_searchable)
#    t.vol(index_as: :stored_searchable)
#    t.section(index_as: :stored_searchable)
#    t.dname(index_as: :stored_searchable)
#    t.subdiv(index_as: :stored_searchable)
#    t.part(index_as: :stored_searchable)
#    t.lang(index_as: :stored_searchable)
#    t.author_b(index_as: :stored_searchable)
#    t.witness(index_as: :stored_searchable)
#    t.wit_b(index_as: :stored_searchable)
#    t.onames(index_as: :stored_searchable)
#    t.odates(index_as: :stored_searchable)
#    t.abstract(index_as: :stored_searchable)
#    t.supages(index_as: :stored_searchable)
#    t.subject(index_as: :stored_searchable)
#    t.collection(index_as: :stored_searchable)
#    t.editorialdecl_n(index_as: :stored_searchable)
#    t.editorialdecl(index_as: :stored_searchable)
#    t.keywords(index_as: :stored_searchable) 
#    t.image(index_as: :stored_searchable)
#    t.bibid(index_as: :stored_searchable)
#    t.callno(index_as: :stored_searchable)
    t.book_ocr(index_as: :searchable)
#    t.edition(index_as: :stored_searchable)
#    t.trial_type(index_as: :stored_searchable)
#    t.crime(index_as: :stored_searchable)
#    t.document_type(index_as: :stored_searchable)
#    t.geo_location(index_as: :stored_searchable)
#    t.repository(index_as: :stored_searchable)

  #  (index_as: :stored_searchable)
  #  t.author(index_as: :stored_searchable)
  end

  def self.xml_template
    Nokogiri::XML.parse("<DLPSTEXTCLASS/>")
  end
  
#  def prefix
#    return ""
#  end
  

end

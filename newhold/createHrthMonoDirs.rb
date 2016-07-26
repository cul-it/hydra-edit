require 'nokogiri'

class Parser

  attr_accessor :doc

  def initialize(filename) 
    file = File.open(filename, "r")
    @doc = Nokogiri::XML(file) 
  end

  def getChildNodeContents(parentNode, childNode) 
    parentNode.xpath(sprintf('./%s',childNode)).each do |node|
      return node.content
    end
  end
  
  def getNode(parentNode)
     return parentNode.xpath()
  end

  def parseRecords(tagname)
     bibID = ""
    editorialdecl = ""
    editorialdecl_n = ""
    pubdate = ""
    date = ""
    pubplace = ""
    publisher = ""
    author = ""
    title = ""
    bibl_titletype = ""
    pubstmt_idno = ""
    availability = ""
    pubstmt_idno_type = ""
    pubstmt_pubplace = ""
    pubstmt_publisher = ""
    extent = ""
    titlestmt_author = ""
    titlestmt_title = ""
    titlestmt_titletype = ""
    keywords = [] 
    pages = ""
    note = []
    vol = ""
    section = ""
    dname = ""
    subdiv = ""
    part = ""
    lang = "" 
    abstract = ""
    number = 0
    book_ocr = []
    edition = ""
    @doc.xpath('.//DLPSTEXTCLASS').each do |wink|
         number = number + 1
       #  puts
       #  puts "How many so far? " + number.to_s
         header = wink.xpath('.//TITLESTMT')
         header.xpath('.//TITLE').each do |tstmt|
           titlestmt_titletype = tstmt.values[0]
    #       puts "titlestmt_titletype = " + titlestmt_titletype
         end
         titlestmt_title = getChildNodeContents(header,"TITLE").encode("UTF-8", "ISO-8859-1")
         titlestmt_author = getChildNodeContents(header,"AUTHOR").encode("UTF-8", "ISO-8859-1")
        # puts "titlestmt_title = " + titlestmt_title
        # puts "titlestmt_author = " + titlestmt_author
         editionpath = wink.xpath('.//EDITIONSTMT')
         edition = ""
         editionpath.xpath('.//EDITION').each do |edt|
            edition = edt.content()
         end
         extent = wink.xpath('.//FILEDESC')
         extent = getChildNodeContents(extent, "EXTENT")
         extent = extent.to_s
         pages = extent.split(' ')[0]
         #puts "pages = "  + pages
         pubstmt = wink.xpath('.//PUBLICATIONSTMT')
         pubstmt_publisher = getChildNodeContents(pubstmt,"PUBLISHER").encode("UTF-8", "ISO-8859-1")
         pubstmt_pubplace = getChildNodeContents(pubstmt,"PUBPLACE").encode("UTF-8", "ISO-8859-1")
         pubstmt.xpath('.//IDNO').each do |idno|
           pubstmt_idno_type = idno.values[0]
         end
         pubstmt_idno = getChildNodeContents(pubstmt,"IDNO")
         puts "mkdir " + pubstmt_idno
  end
 end
end

#data = Parser.new("/cul/data/collections/chla/chla-m-1227-monographs-WithDims-Oct13.xml")
#data = Parser.new("/cul/data/collections/chla/chla-m-28-monographs-WithDims-Dec9.xml")
#data = Parser.new("/cul/data/collections/chla/chla-m-29-monographs-WithDims-Dec07.xml")
data = Parser.new("/collections/hearth/xmlHold/hearth-m-4470.xml")
data.parseRecords("HEADER")
#data.parseRecords("DLPSTEXTCLASS")


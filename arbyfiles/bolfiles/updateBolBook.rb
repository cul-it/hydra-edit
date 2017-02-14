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
    book_ocr = []
    abstract = ""
    alternative_title = ""
    contributor = ""
    contributor_URI = ""
    creator = ""
    creator_URI = ""
    compiler = ""
    editor = ""
    translator = ""
    date_created = ""
    note = ""
    extent = ""
    format = ""
    format_URI = ""
    identifier = ""
    language = ""
    place_of_origin = ""
    publisher = ""
    publisher_URI = ""
    repository_location = ""
    intell_rights = ""
    intell_rights_URI = ""
    subject = []
    subject_URI = ""
    title = ""
    item_type = ""
    item_type_URI = ""
    depositor = ""
    depository = ""
    date_uploaded = ""
    date_modified = ""
    related_url = ""
    pubplace = ""
#    @doc.xpath(sprintf('//%s','TITLESTMT')).each do |header|
#      title = getChildNodeContents(header,"TITLE").encode("UTF-8", "ISO-8859-1")
#      creator = getChildNodeContents(header,"AUTHOR").encode("UTF-8", "ISO-8859-1")
#    end
#    @doc.xpath(sprintf('//%s','FILEDESC')).each do |xtent|
#      extent = getChildNodeContents(xtent, "EXTENT")
#      pages = extent.split(' ')[0]
#    end
#    @doc.xpath(sprintf('//%s','PUBLICATIONSTMT')).each do |pubstmt|
#        temppubstmt_publisher = getChildNodeContents(pubstmt,"PUBLISHER")
#        pubstmt_publisher = temppubstmt_publisher.encode("UTF-8", "ISO-8859-1")
#        temppubstmt_pubplace = getChildNodeContents(pubstmt,"PUBPLACE")
#        pubstmt_pubplace = temppubstmt_pubplace.encode("UTF-8", "ISO-8859-1")
#        pubstmt.xpath('.//IDNO').each do |idno|
#        pubstmt_idno_type = idno.values[0]
#      end
#      pubstmt_idno = getChildNodeContents(pubstmt,"IDNO")
#    end
    @doc.xpath(sprintf('//%s','BIBL')).each do |bibl|
       bibl.xpath('.//TITLE').each do |biblt|
         bibl_titletype = biblt.values[0]
      end
         title = getChildNodeContents(bibl, "TITLE").encode("UTF-8", "ISO-8859-1")
         creator = getChildNodeContents(bibl, "AUTHOR").encode("UTF-8", "ISO-8859-1")
         publisher = getChildNodeContents(bibl, "PUBLISHER").encode("UTF-8", "ISO-8859-1")
         place_of_origin = getChildNodeContents(bibl, "PUBPLACE").encode("UTF-8", "ISO-8859-1")
         date_created = getChildNodeContents(bibl, "DATE").encode("UTF-8", "ISO-8859-1")
         extent = getChildNodeContents(bibl, "NOTE").encode("UTF-8", "ISO-8859-1")
         pubdate = date_created
         pubdate = pubdate.gsub(/[^0-9]/,"")
         pubdate = pubdate[-4..-1]
         if pubdate.blank?
           pubdate = "0000"
         end
         date_created = pubdate
         abstract = getChildNodeContents(bibl, "abstract")
     end
    @doc.xpath(sprintf('//%s','KEYWORDS')).each do |k|
   #   keywords << k.content() << " "
      k.xpath('.//TERM').each do |term|
        if term.content.include? "Bib ID:"
          bibs = term.content().split(': ')
          bibID = bibs.last
        end
        if term.content.include? "Call Number:"
          callnotext = term.content().split(': ')
          callno = callnotext.last
        end
        if term.content.include? "; " and !term.content.include? "Bib ID" and !term.content.include? "Call Number"
          subject = term.content().split('; ')
        else
          if !term.content.include? "Bib ID" and !term.content.include? "Call Number"
            subject << term.content()
          end
        end
      end

   end

    @doc.xpath(sprintf('//%s','EPB1')).each do |l|
       l.xpath('.//P').each do |ocr|
           ocr.content.encode("UTF-8", "ISO-8859-1")
           book_ocr << ocr.content()
       end
    end

    our_identifier = "bol" + ARGV[0]
    image_counter = 0
    record_counter = 0
    repository_name = "Cornell University.Library.Division of Rare and Manuscript Collections"
      puts  creator 
       alt_title = title
       bookpid = "bol" + ARGV[0]
       book1 = Book.find(bookpid)
       book1.our_identifier = [bookpid]
  # puts book1.to_s
       book1.apply_depositor_metadata("jac244@cornell.edu")
  #     col = Collection.find("maypamph")
  #     col.apply_depositor_metadata("jac244@cornell.edu")
  #     book1.member_of_collections << col
       book1.save
      puts "done" 
  end
end
inputparam = ARGV[0]
#if inputparam.nil?
#  puts "You must pass in a record ID"
#  exit
#end
lines = File.foreach('bolivianbooks.txt')
#lines = File.foreach('onebolivianbooks.txt')
lines.each do |line|
  inputparam = line.chomp
  ARGV[0] = line.chomp
data = Parser.new("/collections/bolivian/" + inputparam + "/bol" + inputparam + "_johnAug18_dims.xml")
data.parseRecords("HEADER")
end

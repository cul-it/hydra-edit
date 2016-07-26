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
     callno = ""
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
    pubstmt_idno_type = ""
    pubstmt_pubplace = ""
    pubstmt_publisher = ""
    extent = ""
    titlestmt_author = ""
    titlestmt_title = ""
    titlestmt_titletype = ""
    keywords = []
    pages = ""
    note = ""
    vol = ""
    section = ""
    dname = ""
    subdiv = ""
    part = ""
    lang = ""
    author_b = ""
    witness = ""
    wit_b = ""
    onames = ""
    odates = ""
    abstract = ""
    supages = ""
    book_ocr = []
    @doc.xpath(sprintf('//%s','TITLESTMT')).each do |header|
      header.xpath('.//TITLE').each do |tstmt|
        titlestmt_titletype = tstmt.values[0]
      end
          temptitlestmt_title = getChildNodeContents(header,"TITLE")
      titlestmt_title = temptitlestmt_title.encode("UTF-8", "ISO-8859-1")
      temptitlestmt_author = getChildNodeContents(header,"AUTHOR")
      titlestmt_author = temptitlestmt_author.encode("UTF-8", "ISO-8859-1")
    end
    @doc.xpath(sprintf('//%s','FILEDESC')).each do |xtent|
      extent = getChildNodeContents(xtent, "EXTENT")
      pages = extent.split(' ')[0]
    end
    @doc.xpath(sprintf('//%s','PUBLICATIONSTMT')).each do |pubstmt|
        temppubstmt_publisher = getChildNodeContents(pubstmt,"PUBLISHER")
        pubstmt_publisher = temppubstmt_publisher.encode("UTF-8", "ISO-8859-1")
        temppubstmt_pubplace = getChildNodeContents(pubstmt,"PUBPLACE")
        pubstmt_pubplace = temppubstmt_pubplace.encode("UTF-8", "ISO-8859-1")
        pubstmt.xpath('.//IDNO').each do |idno|
          pubstmt_idno_type = idno.values[0]
        end
        pubstmt_idno = getChildNodeContents(pubstmt,"IDNO")
    end
    @doc.xpath(sprintf('//%s','NOTESSTMT')).each do |notestmt|
       note = getChildNodeContents(notestmt,"NOTE").encode("UTF-8", "ISO-8859-1")   
    end
    @doc.xpath(sprintf('//%s','BIBL')).each do |bibl|
       bibl.xpath('.//TITLE').each do |biblt|
         bibl_titletype = biblt.values[0]
       end
       temptitle = getChildNodeContents(bibl, "TITLE")
       title = temptitle.encode("UTF-8", "ISO-8859-1")
       tempauthor = getChildNodeContents(bibl, "AUTHOR")
       author = tempauthor.encode("UTF-8", "ISO-8859-1")
       temppublisher = getChildNodeContents(bibl, "PUBLISHER")
       publisher = temppublisher.encode("UTF-8", "ISO-8859-1")
       temppubplace = getChildNodeContents(bibl, "PUBPLACE")
       pubplace = temppubplace.encode("UTF-8", "ISO-8859-1")
       date = getChildNodeContents(bibl, "DATE").encode("UTF-8", "ISO-8859-1")
       pubdate = date
       pubdate = pubdate.gsub(/[^0-9]/,"")
       pubdate = pubdate[-4..-1]
       if pubdate.blank?
          pubdate = "0000"
       end
       section = getChildNodeContents(bibl, "section")
       dname = getChildNodeContents(bibl, "dname")
       subdiv = getChildNodeContents(bibl, "subdiv")
       part = getChildNodeContents(bibl, "part")
       lang = getChildNodeContents(bibl, "lang")
       author_b = getChildNodeContents(bibl, "author_b")
       witness = getChildNodeContents(bibl, "witness")
       wit_b = getChildNodeContents(bibl, "wit_b")
       onames = getChildNodeContents(bibl, "onames")
       odates = getChildNodeContents(bibl, "odates")
       abstract = getChildNodeContents(bibl, "abstract")
       supages = getChildNodeContents(bibl, "supages")


    end
    @doc.xpath(sprintf('//%s','ENCODINGDESC')).each do |ncode|
      ncode.xpath('.//EDITORIALDECL').each do |code|
        editorialdecl_n = code.values[0]
        editorialdecl = getChildNodeContents(code,"P")
      end
    end
   # foldertitles = []
    @doc.xpath(sprintf('//%s','TEXTCLASS')).each do |k|
   #   keywords << k.content() << " "
      k.xpath('.//TERM').each do |term|
        if term.content.include? "Bib ID:"
          bibs = term.content().split(': ')
          bibID = bibs.last
        end
        if !term.content.include? "Bib ID"
           keywords << term.content()
        end
      end
      puts "Keywords = " + keywords.to_s
    #  puts "foldertitles = " + foldertitles.to_s
    end

#    @doc.xpath(sprintf('//%s','EPB1')).each do |l|
     #  l.xpath('.//P').each do |ocr|
#           holding = l.content.encode("UTF-8", "ISO-8859-1")
#           book_ocr << holding
     #  end
#    end


    image_counter = 0
    record_counter = 0
       recordNumber = ARGV[0]
       bookpid = "hearth" + recordNumber
       puts "BookID = " + bookpid
#       book = Book.new(id: bookpid, title: [titlestmt_title], alternative_title: [title], 
#                          creator: [titlestmt_author], extent: [extent], 
#                          format: ["Book"], our_identifier: [bookpid], publisher: [pubstmt_publisher],
#                          pubplace: [pubstmt_pubplace],
#                          date_created: pubdate, note: [note],
#                          repository_location: ["Albert R. Mann Library"], 
#                          language: ["English"], 
#                          subject: keywords)
       book = Book.find(bookpid)
       book.apply_depositor_metadata("jac244@cornell.edu")
       col = Collection.find("hearthco")
       col.apply_depositor_metadata("jac244@cornell.edu")
#       book.save
 #       puts book.inspect
#       book.to_solr
#       book.update_index
#       puts "Sleeping for 0.5 seconds"
#       sleep(0.5)
       col.members << book
       col.save
#       col.to_solr
#       col.update_index
      puts "Done with " + bookpid
  end
end
inputparam = ARGV[0]
#if inputparam.nil?
#  puts "You must pass in a record ID"
#  exit
#end
lines = File.foreach('4470IDS.txt')
lines.each do |line|
  inputparam = line.chomp
  ARGV[0] = line.chomp
data = Parser.new("/collections/hearth/" + ARGV[0] + "/hearth-m-" + ARGV[0] + "-monograph-WithDims-July21.xml")
data.parseRecords("HEADER")
end


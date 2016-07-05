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
         pubdate = getChildNodeContents(bibl, "DATE").encode("UTF-8", "ISO-8859-1")
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
          keywords = term.content().split('; ')
        else
          if !term.content.include? "Bib ID" and !term.content.include? "Call Number"
            keywords << term.content()
          end
        end
      end

   end

    @doc.xpath(sprintf('//%s','EPB1')).each do |l|
     #  l.xpath('.//P').each do |ocr|
           holding = l.content.encode("UTF-8", "ISO-8859-1")
           book_ocr << holding
     #  end
    end


    image_counter = 0
    record_counter = 0
       recordNumber = ARGV[0]
       bookpid = "bol:" + recordNumber
       puts "BookID = " + bookpid
     #  thumbnail = "http://hydrastg.library.cornell.edu/fedora/get/seapage:" + ARGV[0] + "_1/thumbnailImage"
     #  puts "1 " + titlestmt_titletype
     #  puts "2 " + titlestmt_author
     #  puts "3 " + extent
     #  puts "4 " + pubstmt_publisher
     #  puts "5 " + pubstmt_pubplace
     #  puts "6 " + pubstmt_idno_type
     #  puts "7 " + pubstmt_idno
     #  puts "8 " + bibl_titletype
     #  puts "9 "  + title
     #  puts "10 " + author
     #  puts "11 " + publisher
     #  puts "12 " + pubplace
     #  puts "13 " + pubdate
     #  puts "14 " + note
      # puts "15" + book_ocr.to_s
       book = Book.create(pid: bookpid, titlestmt_titletype: titlestmt_titletype, titlestmt_title: titlestmt_title,
                          titlestmt_author: titlestmt_author, extent: extent, pubstmt_publisher: pubstmt_publisher,
                          pubstmt_pubplace: pubstmt_pubplace, pubstmt_idno_type: pubstmt_idno_type,
                          pubstmt_idno: pubstmt_idno,
                          bibl_titletype: bibl_titletype, title: title, author: author, publisher: publisher,
                          pubplace: pubplace,
                          pubdate: pubdate, note: note,
                          repository: "Division of Rare and Manuscript Collections", book_ocr: book_ocr, 
                          lang: "Spanish", 
                          subject: keywords, collection: "Alfred Montalvo Bolivian Digital Pamphlets Collection", editorialdecl_n: editorialdecl_n,
                           editorialdecl: editorialdecl ,
                          # keywords: keywords, 
                          bibid: bibID, callno: callno)
#puts page
       for i in 1..pages.to_i
       #  num = ""
         num = i.to_s
        # if i < 10
        #   num = "000" + i.to_s
        # end
        # if i > 9 and i < 100
        #   num = "00" + i.to_s
        #end
        # if i > 99 and i < 1000
        #   num = "0" + i.to_s
        # end
         recordNumber = ARGV[0]
         pagetext = "info:fedora/bol:" + recordNumber + "_" + num
         book.add_relationship(:has_pages, pagetext, versionable=false)
           book.digitalImage.content = File.open("/cul/data/collections/bolivian/" + ARGV[0] + "/jpg/" + ARGV[0] + "0001.jpg")
           book.thumbnailImage.content = File.open("/cul/data/collections/bolivian/" + ARGV[0] + "/thumbs/" + ARGV[0] + "0001.jpg")
      #     book.pdf.content = File.open("/cul/data/collections/bolivian/" + ARGV[0] + "/pdfs/" + ARGV[0] + ".pdf")

       end
       book.save
       book.to_solr
      puts bookpid
  end
end
inputparam = ARGV[0]
ARGV[1] = inputparam[0..2].upcase + "_" + inputparam[3..8].upcase
ARGV[2] = inputparam[3..8]
if inputparam.nil?
  puts "You must pass in a record ID"
  exit
end
data = Parser.new("/cul/data/collections/bolivian/" + inputparam + "/bol" + inputparam + "_johnAug18_dims.xml")
data.parseRecords("HEADER")


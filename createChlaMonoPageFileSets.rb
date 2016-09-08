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
    keywords = []
    titlestmt_titletype = ""
    titlestmt_title = ""
    titlestmt_author = ""
    extent = ""
    pages = ""
    pubstmt_publisher = ""
    pubstmt_pubplace = ""
    pubstmt_idno_type = ""
    pubstmt_idno = ""
    bibl_titletype = ""
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
    editorialdecl_n = ""
    editorialdecl = ""
    subject = []
    head = ""
    title = @doc.xpath(sprintf('//%s', 'TITLE'))[0].content
    author = @doc.xpath(sprintf('//%s', 'AUTHOR'))[0].content
    publisher = @doc.xpath(sprintf('//%s', 'BIBL//PUBLISHER'))[0].content
    pubplace = @doc.xpath(sprintf('//%s', 'BIBL//PUBPLACE'))[0].content
    pubdate = @doc.xpath(sprintf('//%s', 'BIBL//DATE'))[0].content
    puts title
    #puts author
    #puts publisher
    #puts pubplace
    #puts pubdate
#    puts "START OF PAGES"
    head = ""

        @doc.xpath(sprintf('//%s','TITLESTMT')).each do |header|
      header.xpath('.//TITLE').each do |tstmt|
        titlestmt_titletype = tstmt.values[0]
      end
      titlestmt_title = getChildNodeContents(header,"TITLE").encode("UTF-8","ISO-8859-1")
      titlestmt_author = getChildNodeContents(header,"AUTHOR").encode("UTF-8",    "ISO-8859-1")
    end
    @doc.xpath(sprintf('//%s','FILEDESC')).each do |xtent|
      extent = getChildNodeContents(xtent, "EXTENT")
      pages = extent.split(' ')[0]
    end
    @doc.xpath(sprintf('//%s','PUBLICATIONSTMT')).each do |pubstmt|
      pubstmt_publisher = getChildNodeContents(pubstmt,"PUBLISHER").encode("UTF-8",    "ISO-8859-1")
      pubstmt_pubplace = getChildNodeContents(pubstmt,"PUBPLACE").encode("UTF-8",    "ISO-8859-1")
      pubstmt.xpath('.//IDNO').each do |idno|
        pubstmt_idno_type = idno.values[0]
      end
      pubstmt_idno = getChildNodeContents(pubstmt,"IDNO")
    end
    @doc.xpath(sprintf('//%s','BIBL')).each do |bibl|
       bibl.xpath('.//TITLE').each do |biblt|
         bibl_titletype = biblt.values[0]
      end
         title = getChildNodeContents(bibl, "TITLE").encode("UTF-8",    "ISO-8859-1")
         author = getChildNodeContents(bibl, "AUTHOR").encode("UTF-8",    "ISO-8859-1")
         publisher = getChildNodeContents(bibl, "PUBLISHER").encode("UTF-8",    "ISO-8859-1")
         pubplace = getChildNodeContents(bibl, "PUBPLACE").encode("UTF-8",    "ISO-8859-1")
         pubdate = getChildNodeContents(bibl, "DATE").encode("UTF-8",    "ISO-8859-1")
         note = getChildNodeContents(bibl, "NOTE")
         vol = getChildNodeContents(bibl, "vol")
         section = getChildNodeContents(bibl, "section")
         dname = getChildNodeContents(bibl, "dname")
         subdiv = getChildNodeContents(bibl, "subdiv")
         part = getChildNodeContents(bibl, "part")
         lang = getChildNodeContents(bibl, "lang")


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
           subject = term.content().split('; ')
         #  puts "subject1 = " +  subject
         else
           if !term.content.include? "Bib ID" and !term.content.include? "Call Number"
             subject << term.content()
          #   puts "subject2 = " + subject
           end
         end
       end

    end



    image_counter = 0
    record_counter = 0
    @doc.xpath(sprintf('//%s',tagname)).each do |record|
           #   puts
           #   puts "START OF DIV1 PAGES"
           #   puts
            image_ref = " "
            image_seq = " "
            image_res = " "
            image_fmt = " "
            image_dim = " "
            image_ftr = " "
            image_n = " "
            image_format = " "
            image_geo = " "
            image_date = " "
            image_keyword = " "
            image_caption = " "
            image_ocr = " "
            head = ""

       node = record.values[0] #.split(':')[1]
       node_type = record.values[1]
       head = getChildNodeContents(record,"HEAD")
       if head == 0 or head.nil?
         head = ""
       end

       epb1 = getChildNodeContents(record,"EPB1")
       epbs1 = record.xpath('.//EPB1')
       epbs1count = 0
               image_keyword_add = []
       record.xpath('PB1').each do |pb1|
            image_ref = " "
#            image_seq = " " 
            teststring = pb1.values[1].sub!(/^0+/,"")
            next if image_seq == teststring
            image_res = " "
            image_fmt = " "
            image_dim = " "
            image_ftr = " "
            image_n = " "
         next if image_seq == pb1.values[1]
            image_ref = pb1.values[0]
            image_seq = pb1.values[1]
            image_seq.sub!(/^0+/,"")
            image_res = pb1.values[2]
            image_fmt = pb1.values[3]
            image_dim = pb1.values[4]
            image_dims = image_dim.split("x")
            image_width = image_dims[0]
            image_height = image_dims[1]
            image_ftr = pb1.values[5]
            image_n = pb1.values[6]
         #   puts image_ref
            image_format = ""
            image_geo = ""
            image_date = ""
            image_ethnic = ""
            image_keyword = ""
            image_caption = ""
            image_ocr = ""
            if !image_ftr.nil?
            title = image_ftr + " " + image_n
            else
            title = image_n
            end

          epbs1[epbs1count].xpath('.//P').each do |pee1|
           #  puts "Ralph" + pee1.content()
               test = pee1.content()
                  image_ocr = pee1.content().encode("UTF-8", "ISO-8859-1")
                  image_ocr.gsub!("\\","")

          end
           if image_ocr.nil?
             image_ocr = " "
           end
          epbs1count = epbs1count + 1
          
          if image_seq.to_i >= 1  
          #bookid = "chla" + ARGV[0]
          pagepid = "chla" + ARGV[0] + "_" + image_seq
           page = Page.find(pagepid)
        #  puts  pagepid
        #  puts subject.to_s
     #     thumbnail = "http://hydrastg.library.cornell.edu/fedora/get/" + pagepid + "/thumbnailImage"
           #if image_seq.to_i >= 3
           #page = Page.new(id: pagepid, subject: subject, title: [title], node: [node], node_type: [node_type], page_number: [image_n], ocr: [image_ocr], our_identifier: [pagepid], heading: [head] )
          #  puts "swing"
          #else
          #end
           filesetid = pagepid + "_fs"
           puts "FileSet ID = " +  filesetid
           if image_seq.to_i >= 1  
             fs = FileSet.new(filesetid)
             fs.image_width = [image_width]
             fs.image_height = [image_height]
             fs.image_filename = [image_ref]
             fs.identifier = [filesetid]
             fs.fileset_identifier = [filesetid]
             fs.awsimage = ["http://s3.amazonaws.com/cul-hydra/chla/" + ARGV[0] + "/jpg/" + image_ref]
             fs.awsthumbnail = ["http://s3.amazonaws.com/cul-hydra/chla/" + ARGV[0] + "/thumbs/" + image_ref]
          else
             fs = FileSet.find(filesetid)
          end
             page.apply_depositor_metadata("jac244@cornell.edu")
             fs.apply_depositor_metadata("jac244@cornell.edu")
             fs.save
        #     fs.to_solr
        #     fs.update_index
             page.members << fs
             page.save
         #    page.to_solr
         #    page.update_index
      #     puts "Members = " + book.members
          # puts "Page = " + page.inspect
            image_format = ""
            image_geo = ""
            image_date = ""
            image_ethnic = ""
            image_keyword = ""
            image_caption = ""
            image_ocr = ""
            head = ""
#              puts
#              puts "END OF IMAGE INFO"
#            puts image_seq
          #  book.save
          #  book.to_solr
            puts "fileset " + image_seq + " in " + pagepid + " saved "
          #  puts "PageID = " +  pagepid
          end
       end
      epbcount = 0

#    puts
#    puts
#    puts "END OF DIV1"
#    puts
#    puts

    end
  end
end
inputparam = ARGV[0]
#if inputparam.nil?
#  puts "You must pass in a record ID"
#  exit
#end
#lines = File.foreach('chlafind.txt')
lines = File.foreach('finishchlafilesets.txt')
#lines = File.foreach('onechlafileset.txt')
lines.each do |line|
  inputparam = line.chomp
  ARGV[0] = line.chomp
data = Parser.new("/collections/chla/" + inputparam + "/chla-m-" + inputparam + "-monograph-WithDims-June10.xml")
data.parseRecords("DIV1")
end

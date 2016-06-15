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
    abstract = ""
    editorialdecl_n = ""
    editorialdecl = ""

    title = @doc.xpath(sprintf('//%s', 'TITLE'))[0].content
    author = @doc.xpath(sprintf('//%s', 'AUTHOR'))[0].content
    publisher = @doc.xpath(sprintf('//%s', 'BIBL//PUBLISHER'))[0].content
    pubplace = @doc.xpath(sprintf('//%s', 'BIBL//PUBPLACE'))[0].content
    pubdate = @doc.xpath(sprintf('//%s', 'BIBL//DATE'))[0].content
    if pubdate != "undated" && pubdate != "Undated"
      pubdate = pubdate[-4..-1] || pubdate
    else
      pubdate = "0000"
    end
    puts title
    puts author
    puts publisher
    puts pubplace
    puts pubdate
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
    @doc.xpath(sprintf('//%s','NOTESSTMT')).each do |notestmt|
      note = getChildNodeContents(notestmt,"NOTE").encode("UTF-8", "ISO-8859-1")
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
         if pubdate != "undated" && pubdate != "Undated"
            pubdate = pubdate[-4..-1] || pubdate
         else
            pubdate = "0000"
         end 
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
           keywords = term.content().split('; ')
         else
           if !term.content.include? "Bib ID" and !term.content.include? "Call Number"
             keywords << term.content()
           end
         end
       end

    end



    image_counter = 0
    record_counter = 0
    @doc.xpath(sprintf('//%s',tagname)).each do |record|
#              puts
#              puts "START OF DIV1 PAGES"
#              puts
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


       node = record.values[0].split(':')[1]
       node_type = record.values[1]
#       puts "NODE = " + node + " TYPE = " + node_type
#       head = record.xpath('HEAD')
       head = getChildNodeContents(record,"HEAD")
#            head = head.gsub!('\"','')
       if head == 0 or head.nil?
         head = ""
#       else
#        head = head.gsub!('\"', '')
       end

       epb1 = getChildNodeContents(record,"EPB1")
   #    puts head
       epbs1 = record.xpath('.//EPB1')
       epbs1count = 0
               image_keyword_add = []
       record.xpath('PB1').each do |pb1|
            image_ref = " "
            image_seq = " "
            image_res = " "
            image_fmt = " "
            image_dim = " "
            image_ftr = " "
            image_n = " "
            image_ref = pb1.values[0]
            image_seq = pb1.values[1]
            image_res = pb1.values[2]
            image_fmt = pb1.values[3]
            image_dim = pb1.values[4]
            image_ftr = pb1.values[5]
            image_n = pb1.values[6]
            title = image_ftr + " " + image_n
            puts image_ref
            image_format = ""
            image_geo = ""
            image_date = ""
            image_ethnic = ""
            image_keyword = ""
            image_caption = ""
            image_ocr = ""

          epbs1[epbs1count].xpath('.//P').each do |pee1|
          #   puts "Ralph" + pee1.content()
               test = pee1.content()
                  image_ocr = pee1.content().encode("UTF-8", "ISO-8859-1")

          end
           if image_ocr.nil?
             image_ocr = " "
           end
          epbs1count = epbs1count + 1
          recordNumber = ARGV[0]
          if recordNumber[1] == "3"
             recordNumber = recordNumber[1..2] + recordNumber[4..5]
          else
             recordNumber = recordNumber[-4..-1]
          end
          pagepid = "ezra" + recordNumber + "_" + image_seq
          #page = Page.new(id: pagepid, subject: [], title: [title], node: [node], node_type: [node_type], page_number: [image_n], ocr: [image_ocr], our_identifier: [pagepid], heading: [head] )
          page = Page.find(pagepid )
          page.title = [title]
          page.apply_depositor_metadata("jac244@cornell.edu")
          page.save
          page.to_solr
          page.update_index
   #        puts "Got Here"
   #        puts "Here too"
  #         puts "Hey Man"
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
            puts "Page " + image_seq + " in " + ARGV[0] + " saved "
            puts "PageID = " +  pagepid
       end
      epbcount = 0
      @div2 = Nokogiri::XML::fragment(record.xpath('.//DIV2'))
       image_caption = ""
       image_ocr = ""
       @div2.xpath('.//DIV2').each do |div3|
#              puts
#              puts "START OF DIV2"
#              puts
         image_ref = " "
         image_seq = " "
         image_res = " "
         image_fmt = " "
         image_dim = " "
         image_ftr = " "
         image_n = " "
         image_format = ""
         image_geo = ""
         image_date = ""
         image_ethnic = ""
         image_keyword = ""
         image_caption = ""
         image_ocr = ""

         node = div3.values[0].split(':')[1]
         node_type = div3.values[1]
#         puts "NODE = " + node + " TYPE = " + node_type
         head2 = getChildNodeContents(div3,"HEAD")
    #        head2 = head2.gsub!('\"','')
#         puts head2
         if head2 == 0
           head2 = " "
         end
         epbs = div3.xpath('EPB')
         image_format = ""
         image_geo = ""
         image_date = ""
         image_ethnic = ""
         image_keyword = ""
         image_caption = ""
         image_ocr = ""

         epbcount = 0
               image_keyword_add = []
         div3.xpath('.//PB').each do |pb|
#            puts
#            puts "START OF IMAGE INFO"
#            puts
            image_ref = " "
            image_seq = " "
            image_res = " "
            image_fmt = " "
            image_dim = " "
            image_ftr = " "
            image_n = " "
            image_ref = pb.values[0]
            image_seq = pb.values[1]
            image_res = pb.values[2]
            image_fmt = pb.values[3]
            image_dim = pb.values[4]
            image_ftr = pb.values[5]
            image_n = pb.values[6]
            title = image_ftr + " " + image_n
            puts image_ref
            div4 = div3.xpath('.//EPB')
            div4[epbcount].xpath('.//P').each do |pee|
#              puts "ED " + pee.content()
              test = pee.content()
              case test
               when /^Image\ keyword/i
#                 image_keyword = pee.content().split(':')[1].gsub!(';','')
                  image_keyword = pee.content().split(':')[1] #.strip.gsub!(';','')
                  image_keyword = image_keyword.strip
                  if !image_keyword.nil? and (image_keyword.include? ";" or image_keyword.include? "|")
                    if image_keyword.include? ";"
                      image_keyword = image_keyword.split(';')
                    end
                    if image_keyword.include? "|"
                      image_keyword = image_keyword.split("|")
                    end
                    image_keyword = image_keyword.collect{|x| x.strip}
                    image_keyword = image_keyword.concat image_keyword_add
                   puts image_keyword
                  else
                    image_keyword = image_keyword.strip
                    if image_keyword_add.size > 0
                      puts "here is "
                      puts image_keyword_add
                      puts "image_keyword_add"
                      image_keyword = image_keyword_add << image_keyword
                    end
                    puts image_keyword
                  end
               when /^Image\ caption/i
                 image_caption = pee.content().split(':')[1]
               when /^No\ valid/i
                 image_ocr = pee.content().encode("UTF-8",    "ISO-8859-1") # .split(':')[1]
               else
                 image_ocr = pee.content().encode("UTF-8",    "ISO-8859-1")
              end

          end

              epbcount = epbcount + 1
           if head.nil?
             head = " "
           end
           if image_ethnic.nil?
             image_ethnic = ""
           end
           if image_keyword.nil?
             image_keyword = ""
           end
           if image_ocr.nil?
             image_ocr = ""
           end
        #  case image_seq.length
        #    when 1
        #      image_idno = "000" + image_seq
        #    when 2
        #      image_idno = "00" + image_seq
        #    when 3
        #      image_idno = "0" + image_seq
        #  end
       recordNumber = ARGV[0]
          if recordNumber[1] == "3"
             recordNumber = recordNumber[1..2] + recordNumber[4..5]
          else
             recordNumber = recordNumber[-4..-1]
          end
          pagepid = "ezra" + recordNumber + "_" + image_seq
          #page = Page.new(id: pagepid, subject: [], title: [title], node: [node], node_type: [node_type], page_number: [image_n], ocr: [image_ocr], our_identifier: [pagepid], heading: [head] )
          page = Page.find(pagepid)
          page.title = [title]
          page.apply_depositor_metadata("jac244@cornell.edu")
          page.save
          page.to_solr
          page.update_index
            image_format = ""
            image_geo = ""
            image_date = ""
            image_ethnic = ""
            image_keyword = ""
            image_caption = " "
            image_ocr = ""
            head2 = ""

     #         puts image_seq
              page.save
              page.to_solr
              puts "Page " + image_seq + " in " + ARGV[0] + " saved "
              puts "PageID = " + pagepid
            end

#        puts
#        puts
#        puts "END OF DIV2"
#        puts
#        puts

        end

#    puts
#    puts
#    puts "END OF DIV1"
#    puts
#    puts

    end
  end
end
inputparam = ARGV[0]
if inputparam.nil?
  puts "You must pass in a record ID"
  exit
end
data = Parser.new("/collections/ezra/" + inputparam + "/" + inputparam + "_johnDec2_dims.xml")
data.parseRecords("DIV1")


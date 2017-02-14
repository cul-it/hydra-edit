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
       image_seq = 0
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
  #  puts title
  #  puts author
  #  puts publisher
  #  puts pubplace
  #  puts pubdate
     puts "Adding memberOf to hearth" + ARGV[0]
#    puts "START OF PAGES"
    head = ""

#
    image_counter = 0
    record_counter = 0
    pages = []
    book = Book.find("hearth" + ARGV[0])
   @doc.xpath(sprintf('//%s',tagname)).each do |record|
  
       epb1 = getChildNodeContents(record,"EPB1")
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
            image_seq.sub!(/^0+/,"")
            image_res = pb1.values[2]
            image_fmt = pb1.values[3]
            image_dim = pb1.values[4]
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
                 if image_n.nil?
                    image_n = ""
                 end
            title = image_ftr + " " + image_n
            else
                 if image_n.nil?
                    image_n = ""
                 end
            title = image_n
            end

#          epbs1[epbs1count].xpath('.//P').each do |pee1|
           #  puts "Ralph" + pee1.content()
#               test = pee1.content()
#                  image_ocr = pee1.content().encode("UTF-8", "ISO-8859-1")
#                  image_ocr.gsub!("\\","")

#          end
#           if image_ocr.nil?
#             image_ocr = " "
#           end
          epbs1count = epbs1count + 1
          #puts "Adding pages for " + ARGV[0] 
          if image_seq.to_i >= 1
          pagepid = "hearth" + ARGV[0] + "_" + image_seq
           page = Page.find(pagepid)
       #   end
        #   puts "bear" + pagepid
           puts "Adding " + pagepid + ".member_of hearth" + ARGV[0] 
           page.apply_depositor_metadata("jac244@cornell.edu")
           page.member_of << book
           puts page.member_of.inspect
           page.save
           puts page.member_of.inspect
       #    page.to_solr
       #    page.update_index
          end
       end
      epbcount = 0


    end
  end
end
inputparam = ARGV[0]
#book = Book.find("hearth" + ARGV[0])
if inputparam.nil?
  puts "You must pass in a record ID"
  exit
end
data = Parser.new("/collections/hearth/" + inputparam + "/hearth-m-" + inputparam + "-monograph-WithDims-July21.xml")
data.parseRecords("DIV1")


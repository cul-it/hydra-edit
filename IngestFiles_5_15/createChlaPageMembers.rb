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

  def parseRecords(tagname, seq_array)
    image_seq_array = seq_array
    pagepid = ''
    volume_number_text = ''
    issue_number_text = ''
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
    puts author
    puts publisher
    puts pubplace
    puts pubdate
    puts "START OF PAGES"
    head = ""

        @doc.xpath(sprintf('//%s','TITLESTMT')).each do |header|
      header.xpath('.//TITLE').each do |tstmt|
        titlestmt_titletype = tstmt.values[0]
      end
      titlestmt_title = getChildNodeContents(header,"TITLE").encode("UTF-8","ISO-8859-1")
      titlestmt_author = getChildNodeContents(header,"AUTHOR").encode("UTF-8",    "ISO-8859-1")
      issue_number_text = ''
      title_split = titlestmt_title.split(': ')
 ##     vol_issue_text = title_split[1].split(', ')
 ##     puts "vol_issue_text = " + vol_issue_text.inspect
 ##     volume_text = vol_issue_text[0].split(' ')
 ##     volume_number_text = volume_text[1]
##      if vol_issue_text[1] == 'Index '
##        issue_number_text = 'index'
##      else
##        issue_text = vol_issue_text[1].split(' ')
##        issue_number_text = issue_text[1]
##      end
    end
    @doc.xpath(sprintf('//%s','FILEDESC')).each do |xtent|
      extent = getChildNodeContents(xtent, "EXTENT")
      pages = extent.split(' ')[0]
      puts "pages = " + pages
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
    puts tagname
    issueArray = []
    issuepid = ARGV[0]
                 issue = Issue.find(issuepid)
                 issue.apply_depositor_metadata("jac244@cornell.edu")
    @doc.xpath(sprintf('//%s',tagname)).each do |record|
       record.xpath('.//PB1').each do |pb1|
            image_seq = " "
            image_seq = pb1.values[1]
            puts image_seq
            image_seq.sub!(/^0+/,"")
          #  puts image_seq_array.inspect
          #  puts image_seq
                issuepid = ARGV[0]
                pagepid = issuepid + "_" + image_seq
                puts  pagepid
                  page = Page.find(pagepid)
                 page.apply_depositor_metadata("jac244@cornell.edu")
                 #   puts "Sleeping for 0.5 seconds"
                 issueArray << page
   #              issue.save
                 #         book.to_solr
                 #         book.update_index
       end
      epbcount = 0
     end
    issue.members << issueArray
   return seq_array
  end

end
inputparam = ARGV[0]
seq_array = []
lines = File.foreach("finishPageMembers7031969.txt")
lines.each do |line|
 inputparam = line.chomp
 ARGV[0] = line.chomp
 newid = inputparam
 puts newid
 ARGV[0] = newid
 issuefind = Issue.find(newid)
 our_identifier = issuefind.our_identifier[0]
 puts our_identifier
data = Parser.new("/collections/chla/" + our_identifier + "/chla-s-70-test-serials-WithDimsOCR-Mar15.xml")
seq_array = data.parseRecords("DIV1", seq_array)
#seq_array = data.parseRecords("DIV2", seq_array)
seq_array = []
end
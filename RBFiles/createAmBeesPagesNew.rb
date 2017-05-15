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
#    note = []
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




    @doc.xpath('.//DLPSTEXTCLASS').each do |wink|
         number = number + 1
         puts
         puts "How many so far? " + number.to_s
         header = wink.xpath('.//TITLESTMT')
         header.xpath('.//TITLE').each do |tstmt|
           titlestmt_titletype = tstmt.values[0]
    #       puts "titlestmt_titletype = " + titlestmt_titletype
         end
         titlestmt_title = getChildNodeContents(header,"TITLE").encode("UTF-8", "ISO-8859-1")
         titlestmt_author = getChildNodeContents(header,"AUTHOR").encode("UTF-8", "ISO-8859-1")
         issue_number_text = ''
         title_split = titlestmt_title.split(': ')
         vol_issue_text = title_split[1].split(', ')
         puts "vol_issue_text = " + vol_issue_text.inspect
         volume_text = vol_issue_text[0].split(' ')
         volume_number_text = volume_text[1]
         if vol_issue_text[1] == 'Index '
           issue_number_text = 'index'
         else
           issue_text = vol_issue_text[1].split(' ')
           issue_number_text = issue_text[1]
         end
         puts "volume number = " + volume_number_text
         puts "issue number = " + issue_number_text
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
         puts "pubstmt_idno = " + pubstmt_idno
         availability = ""
         pubstmt.xpath('.//AVAILABILITY').each do |k|
             availability << k.content()
         end
         if availability == ""
            availability = ""
         end
         #puts "AVAILABILITY = " + availability 
         #puts "EDITION = " + edition
       #  if pubstmt_idno == "2688449"
       #    exit
       #  end
##    end
         note = ""
         notestmt = wink.xpath('.//NOTESSTMT')
         notestmt.xpath('.//NOTE').each do |n|
           note = n.content().encode("UTF-8", "ISO-8859-1")
           #puts "note = " + n.content()
         end
         bibl = wink.xpath('.//BIBL')
         bibl.xpath('.//TITLE').each do |biblt|
           bibl_titletype = biblt.values[0]
         end
         title = getChildNodeContents(bibl, "TITLE").encode("UTF-8", "ISO-8859-1")
      #   puts "title = " + title
         creator = getChildNodeContents(bibl, "AUTHOR").encode("UTF-8", "ISO-8859-1")
         publisher = getChildNodeContents(bibl, "PUBLISHER")
         pubplace = getChildNodeContents(bibl, "PUBPLACE").encode("UTF-8", "ISO-8859-1")
         date = getChildNodeContents(bibl, "DATE").encode("UTF-8", "ISO-8859-1")
         pubdate = date
         pubdate = pubdate.gsub(/[^0-9]/,"")
         pubdate = pubdate[-4..-1]
##         vol = getChildNodeContents(bibl, "vol")
##         section = getChildNodeContents(bibl, "section")
##         section = section.to_s
##         section = section.encode("UTF-8", "ISO-8859-1")
##         dname = getChildNodeContents(bibl, "dname")
##         subdiv = getChildNodeContents(bibl, "subdiv")
##         part = getChildNodeContents(bibl, "part")
##     #    lang = getChildNodeContents(bibl, "lang").encode("UTF-8", "ISO-8859-1")
##     #    abstract = getChildNodeContents(bibl, "abstract").encode("UTF-8", "ISO-8859-1")
##     end
         ncode = wink.xpath('.//ENCODINGDESC')
         ncode.xpath('.//EDITORIALDECL').each do |code|
           editorialdecl_n = code.values[0]
           editorialdecl = getChildNodeContents(code,"P").encode("UTF-8", "ISO-8859-1")
         end
         k = wink.xpath('.//KEYWORDS')
         keywords = []
         k.xpath('.//TERM').each do |term|
           if term.content().include? ";"
             #puts term.content
             term.content().encode("UTF-8", "ISO-8859-1")
             keywords = term.content().split(';')
           else
             term.content.encode("UTF-8", "ISO-8859-1")
             keywords << term.content()
             if term.content.include? "Bib ID:"
               bibs = term.content().split(': ')
               bibID = bibs.last
             end         
           end 
         end   
         #puts "Keywords = " + keywords.to_s
         fdupcount = 0
         firstImage = ""
#         wink.xpath(sprintf('.//%s','PB1')).each do |q|
#            if fdupcount < 1
#           #  puts q.values[0]
#             firstImage = q.values[0]
#            end
#            fdupcount = fdupcount + 1
#            break
#         end
#         wink.xpath(sprintf('.//%s','EPB1')).each do |l|
          #  l.xpath('.//P').each do |ocr|
          #     ocr.content.encode("UTF-8", "ISO-8859-1")
#               book_ocr << l.content()
  #            puts "added content" + l.content().encode("UTF-8", "ISO-8859-1")
#         end
  #       book_ocr << ""
        # puts "firstImage = " + firstImage
     #    puts book_ocr
         image_counter = 0
         record_counter = 0
         puts  creator 
         alt_title = titlestmt_title

#        col = Collection.find("corehist")
         issuepid = "hivebees" + "6366245" + "_" + volume_number_text + "_" + issue_number_text 
        puts " entering Journal.new for " + issuepid
        issue = Issue.new(id: issuepid, title: [titlestmt_title], alternative_title: [alt_title], editor: [editor], extent: [extent], 
                           format: ["Issue"], format_URI: [format_URI],  
                           issue_type: [item_type], issue_type_URI: [item_type_URI], 
                           date_uploaded: date_uploaded, date_modified: date_modified, depositor: depositor, note: [note], 
                           publisher: [pubstmt_publisher], date_created: date_created, subject: keywords, language: ["English"], 
                           related_url: [related_url], pubplace: [pubstmt_pubplace], identifier: [issuepid]) 

       issue.apply_depositor_metadata("jac244@cornell.edu")
       journal = Journal.find("hivebees6366245")
       journal.apply_depositor_metadata("jac244@cornell.edu")
       issue.apply_depositor_metadata("jac244@cornell.edu")
       issue.save
       journal.members << issue
       journal.save
         puts "Finished with " + issuepid
         puts
  end
 end
end



inputparam = ARGV[0]
lines = File.foreach("/collections/bees/beefiles.txt")
lines.each do |line|
 inputparam = line.chomp
 topdir = inputparam.split('_')
 topdir_text = topdir[0] + '_' + topdir[1]
 ARGV[0] = line.chomp
 data = Parser.new("/collections/bees/" + topdir_text + "/" + ARGV[0] + "/chla-s-abj-" + ARGV[0] + "-WithDimsOCR-Feb13.xml")
#data.parseRecords("HEADER")
data.parseRecords("DLPSTEXTCLASS")
end


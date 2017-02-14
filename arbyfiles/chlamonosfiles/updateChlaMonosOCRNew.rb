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

    image_counter = 0
    record_counter = 0
    @doc.xpath(sprintf('//%s',tagname)).each do |record|
#       epb1 = getChildNodeContents(record,"EPB1")
 #      epbs1 = record.xpath('.//EPB1')
 #      epbs1count = 0
               image_keyword_add = []
       record.xpath('.//PB1').each do |pb1|
            image_seq = pb1.values[1]
            image_seq.sub!(/^0+/,"")
     #       checkers = pb1.xpath('.//EPB1')
            blah = getChildNodeContents(pb1, "P")
            puts blah
            epb1 = getChildNodeContents(pb1, './/EPB1') 
            image_ocr = epb1
            
            puts image_ocr
	  if image_seq.to_i >= 1 #and image_seq.to_i != 362
          bookid = "chla" + ARGV[0]
          pagepid = "chla" + ARGV[0] + "_" + image_seq
          puts  pagepid
         # puts image_ocr
     #      page = Page.find(pagepid)
     #      page.apply_depositor_metadata("jac244@cornell.edu")
     #      page.ocr = []
     #      page.save
     #      page.ocr = [image_ocr]
     #      page.save
          end
       end
      epbcount = 0

    end
  end
end
inputparam = ARGV[0]
lines = File.foreach("onechlaocrtest.txt")
#lines = File.foreach("onechlamonos.txt")
lines.each do |line|
 inputparam = line.chomp
 ARGV[0] = line.chomp
data = Parser.new("/collections/chla/" + inputparam + "/chla-m-" + inputparam + "-monograph-WithDims-June10.xml")
data.parseRecords("DIV1")
end

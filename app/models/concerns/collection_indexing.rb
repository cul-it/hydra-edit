module CollectionIndexing
  extend ActiveSupport::Concern
  def to_solr(solr_doc = {})
    super.tap do |doc|
      in_collections.each do |col|
        doc[ActiveFedora.index_field_mapper.solr_name("collection_tesim", :symbol)] = col.title
      end
    end
  end

  def collection_ids
    if persisted?
      in_collections.map(&:id)
    else
      []
    end
  end
end

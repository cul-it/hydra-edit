class CollectionForm
  include HydraEditor::Form
  self.model_class = Collection
  self.terms = ["collection_title", "collection_abstract"]
  self.required_fields = ["collection_title"]
end

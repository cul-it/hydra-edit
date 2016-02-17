class BookForm
  include HydraEditor::Form
  self.model_class = Book
  self.terms = ["abstract", "alternative_title"]
  self.required_fields = ["abstract"]
end

class BookForm
  include HydraEditor::Form
  self.model_class = Book
  self.terms = ["title"]
  self.required_fields = ["title"]

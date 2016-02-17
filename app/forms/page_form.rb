class PageForm
  include HydraEditor::Form
  self.model_class = Page
  self.terms = ["digital_work_title", "page_number"]
  self.required_fields = ["digital_work_title"]
end

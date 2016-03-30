# app/presenters/book_presenter.rb
class BookPresenter < CurationConcerns::WorkShowPresenter
  delegate :alternative_title, to: :solr_document
end
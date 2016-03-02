# Generated via
#  `rails generate curation_concerns:work Book`
module CurationConcerns
  class BookActor < CurationConcerns::BaseActor
    include ::CurationConcerns::WorkActorBehavior
  end
end

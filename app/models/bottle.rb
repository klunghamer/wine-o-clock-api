class Bottle < ApplicationRecord
  belongs_to :user
  has_attached_file :image, styles: {
    large: '600x600>',
    medium: '300x300>',
    thumb: '80x80>',
    square: '200x200#'
  }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end

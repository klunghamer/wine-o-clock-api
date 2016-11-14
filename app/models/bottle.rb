class Bottle < ApplicationRecord
  belongs_to :user
  has_attached_file :image, styles: {
    large: '600x600>',
    medium: '300x300>',
    thumb: '200x200>',
    square: '200x200#'
  }

  # def get_bottle_label
  #   {source: bottle.image.url(:large)}
  # end

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end

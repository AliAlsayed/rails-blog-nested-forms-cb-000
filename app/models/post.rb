class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tags, :through => :post_tags
  accepts_nested_attributes_for :tags, reject_if: proc {|attributes| attributes[:title].blank?}
  validates_presence_of :name, :content

  def tags_attributes=(tags_attributes)
    tags_attributes.each do |attributes|
      self.tags << Tag.find_or_create_by(attributes)
    end
  end
end

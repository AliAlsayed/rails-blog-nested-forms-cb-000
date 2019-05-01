class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tags, :through => :post_tags
  accepts_nested_attributes_for :tags, reject_if: proc {|attributes| attributes[:title].blank?}
  validates_presence_of :name, :content

  def tags_attributes=(tag_attributes)
    if tag_attributes.respond_to? :values
      tag_attributes.values.each do |tag_attribute|
        self.tags << Tag.find_or_create_by(tag_attribute)
      end
    end
  end
end

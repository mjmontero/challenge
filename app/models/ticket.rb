class Ticket < ApplicationRecord
  attr_accessor :tags
  validates :user_id, presence: true
  validates :title,   presence: true
  validates :tags, length: {
    maximum: 5,
    message: 'A ticket can only have a maximum of 5 tags'
  }

  before_create :set_received_at
  after_save  :create_tags

  def set_received_at
    self.received_at = DateTime.now
  end
  
  def create_tags
    return unless tags.present?
    tags.map(&:downcase!)

    existing_tags = Tag.where(tag_name: tags)
    tags.each do |tag|
      t = existing_tags.select { |t| t.tag_name == tag }&.first
      t.present? ? t.update(count: t.count + 1) : Tag.create(tag_name: tag, count: 1)
    end

  end
end

class Promotion < ActiveRecord::Base
  has_attached_file :image,
                    styles: { medium: '700x450>', thumb: '272x174>' },
                    default_url: '/images/:style/missing.png',
                    url: '/system/:class/:style/:basename.:extension',
                    path: ':rails_root/public/system/:class/:style/:basename.:extension'
  validates_attachment_content_type :image, content_type: /\Aimage/

  validates_presence_of :title
  validates_presence_of :excerpt
  validates_presence_of :description

  default_scope -> { order(updated_at: :desc) }

  scope :only_active, -> { where(active: true) }
end

class Sport < ActiveRecord::Base
  has_many :game_lines
  has_many :leagues
  has_many :teams

  has_attached_file :image,
                    styles: { large: '900x400>', thumb: '272x174>' },
                    default_url: '/images/:style/missing.png',
                    url: '/system/:class/:style/:basename.:extension',
                    path: ':rails_root/public/system/:class/:style/:basename.:extension'
  validates_attachment_content_type :image, content_type: /\Aimage/
end

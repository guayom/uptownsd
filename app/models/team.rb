class Team < ActiveRecord::Base
	has_attached_file :logo,
										styles: { large: '900x900>', thumb: '250x250>' },
										default_url: '/images/:style/missing.png',
										url: '/system/:class/:style/:basename.:extension',
										path: ':rails_root/public/system/:class/:style/:basename.:extension'
  validates_attachment_content_type :logo, content_type: /\Aimage/

	belongs_to :sport

  validates_presence_of :sport
  validates_presence_of :name

	has_many :game_lines
end

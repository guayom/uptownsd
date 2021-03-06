class Sport < ActiveRecord::Base
  has_attached_file :image,
                    styles: { large: '900x400>', thumb: '272x174>' },
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: /\Aimage/

  validates_presence_of :title

  has_many :game_lines
  has_many :leagues
  has_many :teams

  def to_builder
    Jbuilder.new do |sport|
      sport.(self, :id, :title)
    end
  end
end

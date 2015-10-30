
class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true

  validate :release_date_is_in_the_future

  # scope :by_title,    -> (title) { where("title LIKE ?", "%#{title}%" ) if title.present? }
  # scope :by_director, -> (director) { where("director LIKE ?", "%#{director}%" ) if director.present? }
 
  def self.search(title = nil, director = nil, runtime = nil)
   
    movie = Movie.all

    movie = movie.where("title LIKE ?", "%#{title}%") unless title.nil? || title.empty?
    movie = movie.where("director LIKE ?", "%#{director}%") unless director.nil? || director.empty?
    movie = case runtime
            when 'short' then movie.where("runtime_in_minutes < ?", 90)
            when 'medium' then movie.where("runtime_in_minutes between ? and ?", 90, 120)
            when 'long' then movie.where("runtime_in_minutes > ?", 120)
            else
              movie
            end
    movie
  end

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def validate_image(image)
    return unless image.attached?
    
    unless image.byte_size <= 1.megabyte
      errors.add(:image, '{too_big}')
    end
  
    acceptable_types = ['image/jpeg', 'image/png']
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, '{must_be_a_jpeg_or_png}')
    end
  end
end

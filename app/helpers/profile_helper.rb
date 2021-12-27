module ProfileHelper
  def resize_avatar(avatar)
    return unless avatar

    acceptable_types = ['image/jpeg', 'image/png']
    return unless acceptable_types.include?(avatar.content_type)

    temp_path = avatar.tempfile.path

    image = MiniMagick::Image.open(temp_path)
    if image.height < image.width
      diff = (image.width - image.height) / 2
      image.crop "#{image.height}x#{image.height}+#{diff}+0"
    else
      diff = (image.height - image.width) / 2
      image.crop "#{image.width}x#{image.width}+0+#{diff}"
    end
    image.resize '240x240'
    image.write temp_path
  end
end

require "image_processing/mini_magick"

class ImageUploader < Shrine
  # plugins and uploading logic
  include ImageProcessing::MiniMagick
  plugin :processing
  plugin :versions   # enable Shrine to handle a hash of files
  plugin :delete_raw # delete processed files after uploading

  process(:store) do |io, context|
    original = convert(original, "png")

    size_800 = resize_and_pad(original, 800, 800) { |cmd| cmd.auto_orient } # orient rotated images
    size_500 = resize_and_pad(size_800,  400, 500)
    size_200 = resize_and_pad(size_500,  200, 200)
    thumbnail = resize_and_pad(size_300, 85, 85)

    { original: io, large: size_800, medium: size_500, small: size_200 , thumbnail: thumbnail }
  end
end

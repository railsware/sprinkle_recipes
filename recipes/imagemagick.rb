package :imagemagick do
  description 'ImageMagick image convertion library'
  apt 'imagemagick' 

  verify do
    has_file '/usr/bin/convert'
  end
end
require "yaml"

class Wraith
  attr_accessor :config

  def initialize(config_name)
    @config = YAML::load_file(config_name + '.yaml')
  end

  def engine
    @config['engine']
  end

  def widths
    @config['screen_widths']
  end

  def base_domain
    hash = @config['domains']
    hash[hash.keys[0]]
  end

  def comp_domain
    hash = @config['domains']
    hash[hash.keys[1]]
  end

  def base_domain_label
    @config['domains'].keys[0]
  end

  def comp_domain_label
    @config['domains'].keys[1]
  end

  def paths
    @config['paths']
  end

  def capture_page_image (engine, url, width, file_name)
    file = engine == 'casperjs' ? 'capture' : 'snap'
    puts `"#{engine}" "#{file}".js "#{url}" "#{width}" "#{file_name}"`
  end

  # Support for slimerjs, uncomment code below and comment out capture_page_image option above
  # def capture_page_image (url, width, file_name)
  #   puts `slimerjs snap.js "#{url}" "#{width}" "#{file_name}"`
  # end

  def compare_images (base, compare, output, info)
    puts `compare -fuzz 20% -metric AE -highlight-color blue #{base} #{compare} #{output} 2>#{info}`
  end

  def self.crop_images (crop, height)
    puts `convert #{crop} -extent 0x#{height} #{crop}`  
  end

  def crop_images(crop, height)
    self.class.crop_images
  end 
 
  def thumbnail_image(png_path, output_path)
      `convert #{png_path} -thumbnail 200 -crop 200x200+0+0 #{output_path}`
  end
end  

module PaperclipValidations
  # Places ActiveRecord-style validations on the ratio of the dimensions of the file assigned.
  # 
  #   # restricts the image from a perfectly square shape to 16:9 widescreen.
  #   validates_ratio_of :image, :with => (1.0)..(1.78)
  #
  def validates_ratio_of name, options={}
    attachment_definitions[name][:validations][:ratio] = lambda do |attachment, instance|
      path = instance.send(name).queued_for_write[:original]
      if path
        dimensions       = Paperclip::Geometry.from_file path
        ratio_dimensions = [dimensions.width, dimensions.height].sort.reverse
        ratio            = ratio_dimensions.first / ratio_dimensions.last.to_f

        message = options[:message] || "ratio must be #{options[:with].first} to #{options[:with].last}"
        message unless options[:with].include? ratio
      end
    end
  end

  # Places ActiveRecord-style validations on the dimensions of the file assigned.  The
  # possible options are:
  #
  # * +width+: A width range or integer (e.g., 1..200, 200)
  # * +height+: A height range or integer (e.g., 1..200, 200)
  # * +message+: An error message overriding the default
  #
  #   validates_dimensions_of :image, :width => 125..1024, :height => 125..1024
  #
  def validates_dimensions_of name, options = {}
    attachment_definitions[name][:validations][:dimensions] = lambda do |attachment, instance|
      path = instance.send(name).queued_for_write[:original]
      if path
        dimensions = Paperclip::Geometry.from_file path
        message    = options[:message] || "dimensions must be #{options[:width]}px wide by #{options[:height]}px tall"

        message unless (options[:width].present? and options[:width] === dimensions.width) or
        (options[:height].present? and options[:height] === dimensions.height)
      end
    end
  end
end

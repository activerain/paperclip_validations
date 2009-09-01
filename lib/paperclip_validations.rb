
module PaperclipValidations
  # Places ActiveRecord-style validations on the ratio of the dimensions of the file assigned.
  # 
  #   # restricts the image from a perfectly square shape to 16:9 widescreen.
  #   validates_ratio_of :image, :with => (1.0)..(1.78)
  #
  def validates_ratio_of name, options={}
    attachment_definitions[name][:validations] << [:ratio, options]
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
    attachment_definitions[name][:validations] << [:dimensions, options]
  end
end

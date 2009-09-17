module Paperclip
  class Attachment
    def validate_ratio options
      if @queued_for_write[:original].present?
        dimensions       = Paperclip::Geometry.from_file @queued_for_write[:original]
        ratio_dimensions = [dimensions.width, dimensions.height].sort.reverse
        ratio            = ratio_dimensions.first / ratio_dimensions.last.to_f

        message = options[:message] || "ratio must be #{options[:with].first} to #{options[:with].last}"
        message unless options[:with].include? ratio
      end
    end

    def validate_dimensions options
      if @queued_for_write[:original].present?
        dimensions = Paperclip::Geometry.from_file @queued_for_write[:original]
        message    = options[:message] || "dimensions must be #{options[:width]}px wide by #{options[:height]}px tall"

        message unless (options[:width].present? and options[:width] === dimensions.width) and
        (options[:height].present? and options[:height] === dimensions.height)
      end
    end
  end
end



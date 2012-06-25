module PhasesHelper
  def phase_image_link(phase, options = {})
    options.reverse_merge! size: 150
    image_tag(phase.image_url, alt: phase.title, width: options[:size], height: options[:size])
  end
end

##
# A place to put general utility methods which are used all over the place.
module ApplicationHelper
  ##
  # Make a link to an icon.  In the future the colour, size, and format
  # might come from application configuration.
  def make_icon_tag(image_name, opts={})
    colour = 'blue'
    size   = '16x16'
    format = 'png'
    file   = if image_name == 'blank'
               'blank.gif'
             else
               ['icons',
                format,
                colour,
                size,
                "#{image_name}.#{format}",
               ].join('/')
             end

    opts[:size] ||= size
    image_tag file, opts
  end
end

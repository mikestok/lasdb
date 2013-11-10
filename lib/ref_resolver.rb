# This class encapuslates the conversion of <code>{{ref}}</code> in a piece of
# text to the appropriate tag.
#
# Its primary use is in the Question module so that we can eventually
# shuffle the answers around, but still make sure that a question of the
# form:
#
#     a. foo
#     b. bar
#     c. baz
#     d. {{a}} and {{c}}
#
# tracks the tags in answer _d_ to match the tags in the shuffled
# version of the answers with content _foo_ and _baz_.
class RefResolver

  ##
  # Sets up state so we can later map any non-blank
  # references to the associated tag.
  def initialize(ref_list, tag_list)
    @ref_to_tag =
      ref_list.zip(tag_list).
      reject { |pair| pair[0].blank? }.
      reduce({}) do |hash, pair|
        hash.merge({ pair[0] => pair[1] })
      end
  end

  ##
  # Passed in a string this substitutes any <code>{{ref}}</code> markers with
  # the appropriate tag text.
  def resolve_refs(text)
    result = text.dup
    @ref_to_tag.each_pair do |ref, tag|
      result.gsub!(/{{#{ref}}}/, tag)
    end
    return result
  end
end

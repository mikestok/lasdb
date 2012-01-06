# This class encapuslates the conversion of {{ref}} in a piece of
# text to the appropriate tag.
# 
# Its primary use is in the Question module so that we can eventually
# shuffle the answers around, but still make sure that
#
# a, foo
# b. bar
# c. baz
# d. a and c
#
# tracks the tags for a and c.
class RefResolver
  # in: list of references
  #     list of tags
  #
  # sets up state so we can later map any non-blank 
  # references to the associated tag.
  def initialize(ref_list, tag_list)
    @ref_to_tag =
      ref_list.zip(tag_list).
      reject {|pair| pair[0].blank? }.
      inject({}) do |hash, pair|
        hash.merge({ pair[0] => pair[1] })
      end
  end

  def resolve_refs(text)
    result = text.dup
    @ref_to_tag.each_pair do |ref, tag|
      result.gsub!(/{{#{ref}}}/, tag)
    end
    return result
  end
end

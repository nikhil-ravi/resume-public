-- Function: Pandoc
-- Description: This function is the entry point for the Pandoc filter. It checks 
--   each span element in the document for the class 'privatize'. If the class is
--   found, the span is removed from the document if the privatize metadata is set
--   to true. Otherwise, the span is unwrapped and its contents are returned.
-- Parameters:
--   - doc: The Pandoc document to be processed.
function Pandoc (doc)
  local privatize = doc.meta['privatize']
  return doc:walk {
    Span = function (span)
      if span.classes:includes 'privatize' then
        return privatize and
          {} or               -- otherwise return an empty list of elements
          span.content        -- unwrap the span, just return the contents
      end
    end
  }
end
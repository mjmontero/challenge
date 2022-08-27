if tag.nil?
  json.null!
else
  json.extract! tag,
  :tag_name,
  :count
end

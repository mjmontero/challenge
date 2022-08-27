if ticket.nil?
  json.null!
else
  json.extract! ticket,
  :user_id,
  :title
  
end
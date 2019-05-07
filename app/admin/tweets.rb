ActiveAdmin.register Tweet do
    permit_params :content, :likes, :dislikes, :user_id
end

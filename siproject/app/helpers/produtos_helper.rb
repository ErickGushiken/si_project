module ProdutosHelper
    def produto_author(produto)
        user_signed_in? && current_user.id == produto.user_id
    end    
end

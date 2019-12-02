module ProdutosHelper
    def produto_author(produto)
        current_user.documento == produto.user_id
    end    
end

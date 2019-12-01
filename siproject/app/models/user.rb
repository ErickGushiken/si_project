class User < ApplicationRecord
  has_secure_password

  HUMANIZED_ATTRIBUTES = {
    :email => "Email",
    :password => "senha",
    :password_confirmation => "Confirmação de senha",
    :data_nasc => "Data de nascimento",
  }

  # Essa função altera o nome do atributo para mostrar as mensagens de erro
  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  # validates :email, presence: true, uniqueness: true
  validates :nome, presence: {message: 'O campo nome é obrigatório'}
  validates :data_nasc, presence: {message:'A data de nascimento é obrigatória'}
  # validates :documento, presence: {message: 'não pode ser deixado em branco'}

  validates :email,
    presence: {message: 'O campo email é obrigatório'}, 
    uniqueness: {message: 'Esse email já está cadastrado'},
    format: {with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message:"Email inserido possui formato inválido"}


  validate :validate_documento
  validate :validate_idade
    
  
  def validate_idade
    if data_nasc.present? && data_nasc.to_i > 18.years.ago.to_i
      errors.add(:data_nasc, 'Data de nascimento inválida, Você precisa ter mais de 18 anos.')
    end
  end
  
  def validate_documento
    if tipo==1 && !check_cpf(documento)
      errors.add(:documento, 'CPF inválido.')
    end

    if tipo==0 && !check_cnpj(documento) 
      errors.add(:documento, 'CNPJ inválido.')
    end
  end

  def check_cpf(cpf=nil)
    return false if cpf.nil?
  
    nulos = %w{12345678909 11111111111 22222222222 33333333333 44444444444 55555555555 66666666666 77777777777 88888888888 99999999999 00000000000 12345678909}
    valor = cpf.scan /[0-9]/
    if valor.length == 11
      unless nulos.member?(valor.join)
        valor = valor.collect{|x| x.to_i}
        soma = 10*valor[0]+9*valor[1]+8*valor[2]+7*valor[3]+6*valor[4]+5*valor[5]+4*valor[6]+3*valor[7]+2*valor[8]
        soma = soma - (11 * (soma/11))
        resultado1 = (soma == 0 or soma == 1) ? 0 : 11 - soma
        if resultado1 == valor[9]
          soma = valor[0]*11+valor[1]*10+valor[2]*9+valor[3]*8+valor[4]*7+valor[5]*6+valor[6]*5+valor[7]*4+valor[8]*3+valor[9]*2
          soma = soma - (11 * (soma/11))
          resultado2 = (soma == 0 or soma == 1) ? 0 : 11 - soma
          return true if resultado2 == valor[10] # CPF válido
        end
      end
    end
    return false # CPF inválido
  end
  
  def check_cnpj(cnpj=nil)
    return false if cnpj.nil?
  
    nulos = %w{11111111111111 22222222222222 33333333333333 44444444444444 55555555555555 66666666666666 77777777777777 88888888888888 99999999999999 00000000000000}
    valor = cnpj.scan /[0-9]/
    if valor.length == 14
      unless nulos.member?(valor.join)
        valor = valor.collect{|x| x.to_i}
        soma = valor[0]*5+valor[1]*4+valor[2]*3+valor[3]*2+valor[4]*9+valor[5]*8+valor[6]*7+valor[7]*6+valor[8]*5+valor[9]*4+valor[10]*3+valor[11]*2
        soma = soma - (11*(soma/11))
        resultado1 = (soma==0 || soma==1) ? 0 : 11 - soma
        if resultado1 == valor[12]
          soma = valor[0]*6+valor[1]*5+valor[2]*4+valor[3]*3+valor[4]*2+valor[5]*9+valor[6]*8+valor[7]*7+valor[8]*6+valor[9]*5+valor[10]*4+valor[11]*3+valor[12]*2
          soma = soma - (11*(soma/11))
          resultado2 = (soma == 0 || soma == 1) ? 0 : 11 - soma
          return true if resultado2 == valor[13] # CNPJ válido
        end
      end
    end
    return false # CNPJ inválido
  end

end

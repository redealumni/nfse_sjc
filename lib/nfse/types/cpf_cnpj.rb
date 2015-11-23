module NFSe
  module Types
    class CPF_CNPJ < Base
      def process
        build_field 'Cpf' if params.Cpf
        build_field 'Cnpj' if params.Cnpj
      end
    end
  end
end

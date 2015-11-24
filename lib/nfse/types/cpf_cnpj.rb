module NFSe
  module Types
    class CPF_CNPJ < Base
      def process
        choice('Cpf', 'Cnpj') do
          build_field 'Cpf', :optional
          build_field 'Cnpj', :optional
        end
      end
    end
  end
end

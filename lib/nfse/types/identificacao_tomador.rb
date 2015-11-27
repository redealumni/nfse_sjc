module NFSe
  module Types
    class IdentificacaoTomador < Base
      def process
        build_into_self 'CpfCnpj', of: Types::CpfCnpj
        build_field 'InscricaoMunicipal', :optional
      end
    end
  end
end

module NFSe
  module Types
    class IdentificacaoIntermediarioServico < Base
      def process
        build_field 'RazaoSocial'
        build_into_self 'CpfCnpj', of: Types::CpfCnpj
        build_field 'InscricaoMunicipal', :optional
      end
    end
  end
end

module NFSe
  module Documents
    class EnviarLoteRps < Base
      def process
        xml.EnviarLoteRpsEnvio do
          build_into_self 'LoteRps', of: Types::LoteRps
          build_into_self 'Signature', of: Types::Signature
        end
      end
    end
  end
end

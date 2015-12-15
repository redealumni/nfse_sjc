module NfseSjc
  module Schemas
    MAPPING = {
      'cabecalho_v3.xml.erb' => 'cabecalho_v03.xsd',
      'cancelar_nfse_v3.xml.erb' => 'servico_cancelar_nfse_envio_v03.xsd',
      'consultar_lote_rps_v3.xml.erb' => 'servico_consultar_lote_rps_envio_v03.xsd',
      'consultar_nfse_rps_v3.xml.erb' => 'servico_consultar_nfse_rps_envio_v03.xsd',
      'consultar_nfse_v3.xml.erb' => 'servico_consultar_nfse_envio_v03.xsd',
      'consultar_situacao_lote_rps_v3.xml.erb' => 'servico_consultar_situacao_lote_rps_envio_v03.xsd',
      'recepcionar_lote_rps_v3.xml.erb' => 'servico_enviar_lote_rps_envio_v03.xsd'
    }

    def self.get_schema(template)
      MAPPING[template]
    end
  end
end

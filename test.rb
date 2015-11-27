h = {
  'Versao' => 1,
  'LoteRps' => {
    'Id' => 1,
    'NumeroLote' => 1,
    'Cnpj' => '1111',
    'InscricaoMunicipal' => '1111',
    'QuantidadeRps' => 1,
    'Rps' => [{
      'InfRps' => {
        'Id' => 1,
        'IdentificacaoRps' => {},
        'DataEmissao' => '11/11/1992',
        'NaturezaOperacao' => 'ads',
        'RegimeEspecialTributacao' => 'sim',
        'OptanteSimplesNacional' => 'sim',
        'IncentivadorCultural' => 'sim',
        'Status' => 'ok',
        'RpsSubstituido' => {},
        'Servico' => {},
        'Prestador' => {},
        'Tomador' => {},
        'IntermediarioServico' => {},
        'ConstrucaoCivil' => {}
      }
    }]
  }
}

begin
  NFSe::Documents::EnviarLoteRps.create("teste", NFSe::Params.new(h))
rescue => e
  puts e.backtrace
  raise
end

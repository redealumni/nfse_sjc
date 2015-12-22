# nfse-sjc

Gem para comunicação via API com o sistema de NFS-e da prefeitura de São José dos Campos

## Instalação

Adicione essa linha no Gemfile de sua aplicação:

```ruby
  gem 'nfse_sjc', '~> 0.1.0'
```

Em seguida, execute:

    $ bundle install

Ou instale você mesmo utilizando o seguinte comando:

    $ gem install nfse_sjc

Além disso, é necessário que o `xmlsec` esteja instalado em seu sistema e que seja compatível com a API da versão 1.2.18.

## Como usar a gem

```ruby
  # configuração
  NfseSjc.config do |c|
    c.wsdl                  = 'https://homologacao.ginfes.com.br/ServiceGinfesImpl?wsdl'
    c.ssl_cert_file         = 'CAMINHO_PARA_SEU_CERTIFICADO'
    c.ssl_cert_key_file     = 'CAMINHO_PARA_SUA_CHAVE_PRIVADA'
    c.ssl_cert_key_password = 'SENHA_CHAVE_PRIVADA'
    c.log                   = true
    c.pretty_print_xml      = true
    c.xmlsec_binary_path    = `which xmlsec1`.chomp
  end

  # chamada de api
  ginfes = NfseSjc::Client.new

  # enviar lote RPS
  client.recepcionar_lote_rps_v3({
    'LoteRps' => {
      'Id' => '1234',
      'NumeroLote' => '26',
      'Cnpj' => 'CNPJ_VALIDO',
      'InscricaoMunicipal' => 'IM_VALIDA',
      'ListaRps' => [
        {
          'Id' => '1234',
          'InfRps' => {
            'IdentificacaoRps' => {
              'Numero' => '2345',
              'Serie' => '3456',
              'Tipo' => '1'
            },
            'DataEmissao' => Time.now.strftime('%Y-%m-%dT%H:%M:%S'),
            'NaturezaOperacao' => '1',
            'OptanteSimplesNacional' => '2',
            'IncentivadorCultural' => '2',
            'Status' => '1', # normal
            'Servico' => {
              'Valores' => {
                'ValorServicos' => '1',
                'IssRetido' => '2'
              },
              'ItemListaServico' => '1.03',
              'CodigoTributacaoMunicipio' => '20103001',
              'Discriminacao' => 'Discriminação do serviço',
              'CodigoMunicipio' => '3549904'
            },
            'Prestador' => {
              'Cnpj' => 'CNPJ_VALIDO',
              'InscricaoMunicipal' => 'IM_VALIDA'
            },
            'Tomador' => {
              'CpfCnpj' => {
                'Cpf' => 'CPF_VALIDO'
              },
              'RazaoSocial' => 'João da Silva'
            }
          }
        }
      ]
    }
  })

  # consultar situação do lote
  ginfes.consultar_situacao_lote_rps_v3({
    'Prestador' => {
      'Cnpj' => 'CNPJ_VALIDO',
      'InscricaoMunicipal' => 'IM_VALIDA'
    },
    'Protocolo' => '5901581'
  })

  # consultar lote
  ginfes.consultar_lote_rps_v3({
    'Prestador' => {
      'Cnpj' => 'CNPJ_VALIDO',
      'InscricaoMunicipal' => 'IM_VALIDA'
    },
    'Protocolo' => '5901581'
  })
```

## Certificado e chave

### Extraindo certificado e chave privada .pem a partir do certificado .pfx

Para utilizar a gem, é necessário extrair a chave privada e o certificado (ambos em formato .pem) a partir do certificado .pfx, _caso você tenha acesso somente à senha e ao .pfx_.

Para extrair a chave privada:

```bash
  openssl pkcs12 -in certificado.pfx -nocerts -out chave-privada.pem
```

Para extrair o certificado em formato .pem:

```bash
  openssl pkcs12 -in certificado.pfx -clcerts -nokeys -out certificado.pem
```

## TODO

* Ao invés de referenciar o wsdl correto, referenciar se é ambiente de homologação ou produção
* Permitir configuração de CNPJ e Inscrição Municipal
* API mais high level (classes para resposta, etc)
* Tentar substituir o xmlsec por uma solução mais PORO possível
* Testes

# nfse-sjc

Gem para comunicação via API com o sistema de NFS-e da prefeitura de São José dos Campos

## Instalação

Adicione essa linha no Gemfile de sua aplicação:

```ruby
  gem 'nfse-sjc', '~> 0.0.1'
```

Em seguida, execute:

    $ bundle install

Ou instale você mesmo utilizando o seguinte comando:

    $ gem install nfse-sfc

## Como usar a gem

TODO

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

# nfse-sjc

Gem para comunicação via API com o sistema de NFS-e da prefeitura de São José dos Campos

## Extraindo certificado e chave privada .pem a partir do certificado .pfx

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

- Consertar assinaturas digitais
  - Não estão sendo aceitas pelo webservice, não conseguem ser validadas localmente, mesmo quando geradas diretamente pela biblioteca baixo-nível `xmlsec1`
  - Investigar cadeia de certificados do SINCOR - validação via `xmlsec1` sempre retorna erros do tipo `unable to get local issuer certificate`


### Pelo `xmlsec1`:

* Assinatura:

```bash
  xmlsec1 --sign --privkey-pem cert/key.pem,cert/cert.pem --output signed.xml unsigned.xml
```

* Verificação:

```bash
  xmlsec1 --verify --trusted-pem cert/sincor/ACRaizBrasileira_v2.crt --untrusted-pem <(cat cert/sincor/ACRFBv3.crt cert/sincor/ACSINCORRFBG4.pem ) signed.xml
```

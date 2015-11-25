module NFSe
  module Types
    class Signature < Base
      # Oh boy
      def process
        build_attribute 'Id'
        xml.SignedInfo do
          xml.CanonicalizationMethod do
            build_attribute 'Algorithm', with: params.CanonicalizationMethodAlgorithm
          end
          xml.SignatureMethod do
            build_attribute 'Algorithm', with: params.SignatureMethodAlgorithm
          end
          xml.Reference do
            build_attribute 'URI', with: params.ReferenceURI
            xml.Transforms do
              params.ReferenceTransforms.each do |tr|
                xml.Transform do
                  build_attribute 'Algorithm', with: tr.Algorithm
                  tr.Xpath.each do |xpath|
                    xml.Xpath xpath
                  end
                end
              end
            end
            xml.DigestMethod do
              build_attribute 'Algorithm', with: params.DigestMethodAlgorithm
            end
            build_field 'DigestMethod'
          end
        end
        xml.SignatureValue do
          # Empty...?
        end
        xml.KeyInfo do
          xml.X509Data do
            build_field 'X509Certificate'
          end
        end
      end
    end
  end
end

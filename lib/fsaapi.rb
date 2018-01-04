require 'httparty'
require 'json'
require 'nokogiri'

class FsaApiCall
  include HTTParty
  base_uri 'http://ratings.food.gov.uk'

  # For overriding base_uri in specific calls
  def for_uri(uri)
    current_uri = self.class.base_uri
    self.class.base_uri uri
    yield
    self.class.base_uri current_uri
  end

  def get_all_authorities
    all_authority_info = JSON.parse(self.class.get("/authorities/json").body)
    array_of_authorities = all_authority_info['ArrayOfWebLocalAuthorityAPI']['WebLocalAuthorityAPI']
    5.times do
      array_of_authorities.shift
    end
    array_of_authorities
  end

  def get_authority id
    all_authority_info = Nokogiri::XML(self.class.get("/authorities/xml").body)
    authority_filename = ""
    details_of_authority = []
    all_authority_info.search('WebLocalAuthorityAPI').each do |authority|
      authority_filename = authority.xpath('FileName').text if authority.xpath('LocalAuthorityId').text == id
    end
    unless authority_filename.empty?
      for_uri(authority_filename) do
        authority_info = Nokogiri::XML(self.class.get("").body)
        details_of_authority << authority_info.search('LocalAuthorityName')[0].text
        details_of_authority << authority_info.search('ItemCount').text
        authority_info.search('RatingValue').each do |value|
          details_of_authority << value.text
        end
      end
    end
    details_of_authority
  end
end


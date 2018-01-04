require_relative '../lib/fsaapi'

class Authority
  attr_accessor :LocalAuthorityId, :LocalAuthorityIdCode, :Name, :FriendlyName, :Url, :SchemeUrl, :Email, :RegionName, :FileName, :FileNameWelsh, :EstablishmentCount, :CreationDate, :LastPublishedDate, :SchemeType, :links


  def self.all
    api_call = FsaApiCall.new
    all_authorities = api_call.get_all_authorities
  end

  def self.find id
    api_call = FsaApiCall.new
    authority = api_call.get_authority(id)
  end
end
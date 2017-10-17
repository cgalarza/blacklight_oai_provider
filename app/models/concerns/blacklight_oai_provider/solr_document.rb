module BlacklightOaiProvider::SolrDocument
  extend ActiveSupport::Concern

  def timestamp
    timestamp = get("#{self.class.timestamp_key}")
    raise BlacklightOaiProvider::Exceptions::MissingTimestamp if timestamp.blank?
    Time.parse timestamp
  end

  def to_oai_dc
    export_as('oai_dc_xml')
  end

  module ClassMethods
    attr_writer :timestamp_key

    def timestamp_key
      @timestamp_key ||= 'timestamp'
    end
  end
end

package :geoip, :provides => :geoip_lib do
  description 'GeoIP C Library and free GeoLiteCity database'
  version '1.4.6'

  apt %w(geoip-database geoip-bin)
  
  verify do
    has_file '/usr/bin/geoiplookup'
    has_file '/usr/bin/geoipupdate'
  end
end


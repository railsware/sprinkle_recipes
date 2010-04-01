package :geoip, :provides => :geoip_lib do
  description 'GeoIP C Library and free GeoLiteCity database'
  version '1.4.6'

  source "http://geolite.maxmind.com/download/geoip/api/c/GeoIP-#{version}.tar.gz" do
    prefix '/opt/GeoIP/'
    post :install, 'sudo wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz -P /opt/GeoIP/share/GeoIP/', 'sudo gunzip /opt/GeoIP/share/GeoIP/GeoLiteCity.dat.gz'
  end
  
  verify do
    has_file '/opt/GeoIP/lib/libGeoIP.so'
    has_file '/opt/GeoIP/share/GeoIP/GeoLiteCity.dat'
  end
end


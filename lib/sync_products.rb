require 'net/http'
require 'digest/md5'
require 'time'

class SyncProducts
    @TBURL = 'http://gw.api.taobao.com/router/rest'
    #@APPKEY = '1021568436'
    @APPKEY = '21568436'
    #@APPSECRET = 'andboxc8e561f8f2db54022db2d4b45'
    @APPSECRET = '4868825c8e561f8f2db54022db2d4b45'
    @TBMETHOD = 'taobao.products.search'
    @FORMAT = 'json'
    @VERSION = '2.0'
    @SIGNMETHOD = 'md5'
    @NAME = 'product_id,cid,props,name,pic_url'

    class << self
        def get_products(name)
            uri_params = handler_params(name)  
            uri = URI(@TBURL)
            uri.query = URI.encode_www_form(uri_params)
            res = Net::HTTP.get_response(uri)
            return res.body if res.is_a?(Net::HTTPSuccess)
        end

        def handler_params(name)
            params = {
                :app_key => @APPKEY,
                :fields => @NAME,
                :q => name,
                :format => @FORMAT,
                :method => @TBMETHOD,
                :sign_method => @SIGNMETHOD,
                :timestamp => Time.now.strftime("%F %T"),
                :v => @VERSION
            }

            p_list = params.sort_by{|k, v| k.to_s}.map{|p| p.join}
            #sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('md5'), @APPSECRET, @APPSECRET + p_list.join)
            sign = Digest::MD5.hexdigest(@APPSECRET + p_list.join + @APPSECRET)
            params[:sign] = sign.upcase

            return params
        end
    end
end

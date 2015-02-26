::CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = "93vlzlK9UlO6UhZaVlrZ4RyVanIv5f1meAX_ofK2"
  config.qiniu_secret_key    = '7UGe9arh_jrxTQGa1WLba3D8xDZ-FbXOJSVYAJt7'
  config.qiniu_bucket        = "chinap2p"
  config.qiniu_bucket_domain = "7vzs7d.com1.z0.glb.clouddn.com"
  config.qiniu_bucket_private= true #default is false
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = "http"
end

if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end
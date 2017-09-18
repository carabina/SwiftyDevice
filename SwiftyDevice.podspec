#
# Be sure to run `pod lib lint SwiftyDevice.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyDevice'
  s.version          = '1.0.0'
  s.summary          = 'Swift library to help you know the current used device.'
  s.description      = <<-DESC
SwiftyDevice is a swift library to know the type of device. So you'll easily get the name of the device and it's release date.
                       DESC

  s.homepage         = 'https://github.com/legranddamien/SwiftyDevice'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Damien Legrand'
  s.source           = { :git => 'https://github.com/legranddamien/SwiftyDevice.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/damien_legrand'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SwiftyDevice/Classes/**/*.swift'
  
  s.resource_bundles = {
    'SwiftyDevice' => ['SwiftyDevice/Assets/**/*.plist']
  }

end

platform :ios, ’9.0’

use_frameworks!


target 'Branch Locator' do
    #pod 'LocatorLibrary', :path => ‘/Users/vinay_shi/Desktop/LocatorLibrary’
    pod 'LocatorLibrary', :git => 'https://github.com/vinayshi/LocatorLibrary.git'
end

target 'Branch LocatorTests' do

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
    end
  end
end

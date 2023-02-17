# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'debtdestroyer' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for debtdestroyer
  pod 'SnapKit', '~> 5.0.0'
  pod 'Parse'
  pod 'Parse/UI'
  pod 'Reusable'
  pod 'BRYXBanner'
  pod 'SCLAlertView'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'SwiftConfettiView'
  pod 'SkyFloatingLabelTextField'
  pod 'TTTAttributedLabel'
  pod 'UXCam', "~> 3.4.2"
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
            config.build_settings['ENABLE_BITCODE'] = 'YES'
        end
    end
end

source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'

use_frameworks!

target 'YASD' do
  
  pod 'Swinject', '2.6'
  pod 'SwinjectStoryboard'
  pod 'RxSwift'
  pod 'RxSwiftExt'
  pod 'RxDataSources'
  pod 'RMessage'
  pod 'SwiftSoup'
  pod 'MarkdownKit'
  pod 'Cache', '5.2.0'
  
  target 'YASDTests' do
    inherit! :search_paths
    pod 'RxTest'
    pod 'Cuckoo'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['HexColors'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.0'
      end
    end
  end
end

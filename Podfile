source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'

def common_pods
  pod 'Swinject', '2.6'
  pod 'SwinjectStoryboard'
  pod 'RxSwift'
  pod 'RxDataSources'
  pod 'RMessage'
  pod 'SwiftSoup'
  pod 'MarkdownKit'
  pod 'Cache', '5.2.0'
end

target 'YASD' do
  use_frameworks!
  
  common_pods
end

target 'YASDTests' do
  use_frameworks!
  
  pod 'Cuckoo'
  pod 'RxTest'
  
  common_pods
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

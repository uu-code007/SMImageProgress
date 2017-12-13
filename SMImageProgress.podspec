
Pod::Spec.new do |s|


  s.name         = "SMImageProgress"
  s.version      = "0.0.1"
  s.summary      = "SMImageProgress."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = "SMImageProgress,图片上传加载进度提示"

  s.homepage     = "https://github.com/iossun/SMImageProgress"

  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "sunmu" => "ios_sunmu@icloud.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/iossun/SMImageProgress.git", :tag => "0.0.1" }
  s.source_files  = "SMImageProgress/Classes/*.{h,m}"

end

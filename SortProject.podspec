
Pod::Spec.new do |s|

  s.name         = "SortProject"
  s.version      = "1.0.0"
  s.summary      = "A short description of SortProject."

  s.description  = <<-DESC
                   Testing Private Podspec.

                   * Markdown format.
                   * Don't worry about the indent, we strip it!
                   DESC
  s.homepage     = "https://github.com/sevnqiao/SortProject"
  s.license      = "MIT"
  s.author       = { "Xiong" => "1020203007@qq.com" }
  s.source       = { :git => "https://github.com/sevnqiao/SortProject.git", :tag => "1.0.0" }
  s.source_files = "Sort/*.{h,m}"
  s.frameworks = 'UIKit'
end

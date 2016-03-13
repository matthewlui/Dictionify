#
# Be sure to run `pod lib lint Dictionify.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Dictionify"
  s.version          = "0.1.2"
  s.summary          = "Convert/Init objects to/from NSDictionary with Dictionify."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
Dictionify want to solve the needs of convert objects to dictionary with simple step. By using Dictionify, you don't have to write boring code for each class like dictionary["myPropertyA"] = self.myPropertyA dictionary["myPropertyB"] = self.myPropertyB . . . (or by overriding decode/encode(withCoder)) When you subclass Dictionify, and tag your property with "dynamic", you gain the power of calling toDictionary() to get your dictionary that contain all properties in your class. Also, we allow you to init a object with dictionary. Even more, Dictionify can recorgnize properties in dictionary those are also Dictionify subclass(Included in an Array),instantiate them and put right back in. For example: class Person :Dictionify { dynamic var name :String dynamic var likedBook :[Book] init(name:String){ self.name = name likedBook = [] } } class Book :Dictionify{ dynamic var name :String dynamic var content :String } var ben = Person(name:Ben) var book = Book("I love",content:"Bla Bla Bla...") ben.likedBook = [book] var benDict = ben.toDictionary() var anotherBen = Person(benDict) var anotherBook = anotherBen.likedBook.first 
DESC
  s.homepage         = "https://github.com/matthewlui/Dictionify"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "matthewlui" => "matthewluihk@gmail.com" }
  s.source           = { :git => "https://github.com/matthewlui/Dictionify.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Dictionify' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

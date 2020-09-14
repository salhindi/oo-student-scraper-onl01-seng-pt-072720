require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
  
    doc =Nokogiri::HTML(html)
    
    doc.css(".student-card a").collect do |student|
      {:name => student.css("h4").text,
      :location => student.css("p").text,
      :profile_url => student.attr("href")
      }
    end
  end

  

  def self.scrape_profile_page(profile_url)
    
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    # binding.pry
    profile_hash = {}
# binding.pry
    doc.css(".vitals-container .social-icon-container a").each do |detail| 
        if detail.attr('href').include?("twitter")
          profile_hash[:twitter] = detail.attr('href')
        elsif detail.attr('href').include?("linkedin")
          profile_hash[:linkedin] = detail.attr('href')
        elsif detail.attr('href').include?("github")
          profile_hash[:github] = detail.attr('href')
        elsif detail.attr('href').include?("com/")
          profile_hash[:blog] = detail.attr('href')
        end
        profile_hash[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
        profile_hash[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text
      end
    profile_hash
    
    
  end

end


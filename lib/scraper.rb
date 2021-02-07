require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :student
 @@all = []

  def self.scrape_index_page(index_url)
    students_hash = []
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card").each do |student|
      # binding.pry
      hash = {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }

      students_hash << hash
    end
    students_hash
  end

  def self.scrape_profile_page(profile_url)
    students_hash = {}
    html = Nokogiri::HTML(open(profile_url))
    html.css("div.social-icon-container a").each do |student|
      # binding.pry
      social_links.detect do |e|

     student_page[:twitter] = e if e.include?("twitter")
     student_page[:linkedin] = e if e.include?("linkedin")
     student_page[:github] = e if e.include?("github")

   end

   student_page[:blog] = social_links[3] if social_links[3] != nil
   student_page[:profile_quote] = page.css(".profile-quote")[0].text
   student_page[:bio] = page.css(".description-holder").css('p')[0].text
   student_page
  end

end

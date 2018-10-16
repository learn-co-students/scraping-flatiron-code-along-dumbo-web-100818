require 'nokogiri'
require 'open-uri'
require "pry"

require_relative './course.rb'

class Scraper

    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses
    whole_page = self.get_courses

    whole_page.each do |each_item|
      new_course = Course.new()
      new_course.title = each_item.css("h2").text
      new_course.schedule = each_item.css(".date").text
      new_course.description = each_item.css("p").text 
    end


  end




end

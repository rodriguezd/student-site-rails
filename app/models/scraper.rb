# require "sqlite3"
require "nokogiri"
require "open-uri"

class Scraper

  attr_reader :student_profiles_data

  def initialize
    @index_scrape = []
    @student_profiles_data = []
  end

  def scrape_index(url)
    index_url = Nokogiri::HTML(open(url))
    index_url.search('.home-blog-post .blog-title .big-comment h3 a').each do |link|
       @index_scrape << link.attributes['href'].value.downcase
    end
    @index_scrape
  end

  def scrape_name(data)
    data.search('.ib_main_header').each do |link|
       return link.content
    end
  end

  def scrape_bio(data)
    data.search('#equalize #ok-text-column-2 .services p').each do |link|
       return link.content
    end
  end

  def twitter(data)
    data.search('div.social-icons a').first.attr('href').strip
  end

  def linkedin(data)
    data.search('div.social-icons a')[1].attr('href').strip
  end

  def github(data)
    data.search('div.social-icons a')[2].attr('href').strip
  end

  def quote(data)
    data.search('li#text-7 div.textwidget h3').text.strip
  end

  def scrape_profile_data(student_profile)
    name = scrape_name(student_profile)
    bio = scrape_bio(student_profile)
    twitter = twitter(student_profile)
    linkedin = linkedin(student_profile)
    github = github(student_profile)
    quote = quote(student_profile)

    @student_profiles_data << [:name => name, :bio => bio, :quote => quote, :github => github, :twitter => twitter, :linkedin => linkedin]
  end

  def scrape_profiles
    @index_scrape.each do |student_url|
      begin
      student_url = open("http://students.flatironschool.com/#{student_url}") rescue "404 Not Found"
      next if student_url == "404 Not Found"
      student_profile = Nokogiri::HTML(student_url)
      scrape_profile_data(student_profile)
      rescue
        next
      end
    end
  end

end

# class Database

#   def db_create(db_name)
#     @db = SQLite3::Database.open db_name
#   end

#   def db_table_create(create_statement)
#     @db.execute create_statement
#   end

#   def db_table_insert(values)
#     @db.execute("INSERT INTO students (name, bio, twitter, linkedin, github, quote) VALUES(?, ?, ?, ?, ?, ?)", [values[0], values[1], '', '', '', values[2] ])
#   end

# end

################# MAIN #################

scraper = Scraper.new
# database = Database.new

# db_name = '/Users/drodriguez/development/flatiron/rails/student-site-rails/db/development.sqlite3'
# database.db_create(db_name)

# sql_table_create_statement = 'CREATE TABLE IF NOT EXISTS students(id integer primary key autoincrement, name text, bio text, education text, work text)'
# database.db_table_create(sql_table_create_statement)

scraper.scrape_index('http://students.flatironschool.com')
scraper.scrape_profiles

scraper.student_profiles_data.each do |student|
  Student.create(student)
end

scraper.student_profiles_data.each do |student|
  Student.create(student)
end
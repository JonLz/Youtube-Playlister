require 'open-uri'

class Scraper 

  attr_accessor :link

  def initialize(link)
    @link = link
  end

  def build_link
    scraped = build_results_hash
    
    usr = scraped[:username]
    song_id = scraped[:song_id]
    audio_id = scraped[:audio_id]
    plead = "?plead=please-dont-download-this-or-our-lawyers-wont-let-us-host-audio"

    tumblr_link = 'http://www.tumblr.com/audio_file/'        
    tumblr_link << usr << ?/ << song_id << '/tumblr_' << audio_id << plead
    tumblr_link
  end

  def scrape
    open(@link).read
  end

  def build_results_hash
    match = scrape.match(tumblr_regex)
    results = Hash.new
    1.upto(match.names.length) do |idx|
        results[match.names[idx-1].to_sym] = match[idx]
      end
    results
  end

  def tumblr_regex
    /audio_file\/(?<username>.+)\/(?<song_id>\d+)\/tumblr_(?<audio_id>.+)&color/
  end

end


#http://www.tumblr.com/audio_file/kaepop/11352761077/tumblr_lsvm9fk2Qw1qcup2x?plead=please-dont-download-this-or-our-lawyers-wont-let-us-host-audio

#http://www.tumblr.com/audio_file/kaepop/11352761077/tumblr_lsvm9fk2Qw1qcup2x
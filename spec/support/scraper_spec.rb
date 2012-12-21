require File.dirname(__FILE__) + '/../spec_helper'

describe Scraper do 
  it 'accepts a tumblr link' do
    scraper = Scraper.new('')
    scraper.link.should_not be_nil
  end

  describe '#scrape' do
    it 'can create a hash of link elements from tumblr blogs' do
     
      # example tumblr blog and snipped page content response
      link = 'http://kaepop.tumblr.com/post/11352761077/bubble-tea-river-flows-in-you-sung-by'
      page_content = %q(<div class="audioplayer"><div style="margin: 5px 0 0 5px; width: 18px; overflow:hidden;" id="11352761077"><span id="audio_player_11352761077">[<a href="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" target="_blank">Flash 9</a> is required to listen to audio.]</span><script type="text/javascript">replaceIfFlash(9,"audio_player_11352761077",'\x3cdiv class=\x22audio_player\x22\x3e<embed type="application/x-shockwave-flash" src="http://assets.tumblr.com/swf/audio_player_black.swf?audio_file=http://www.tumblr.com/audio_file/kaepop/11352761077/tumblr_lsvm9fk2Qw1qcup2x&color=FFFFFF&logo=soundcloud" height="27" width="207" quality="best" wmode="opaque"></embed>\x3c/div\x3e')</script></div></div>)
     
      scraper = Scraper.new(link)
      scraper.stub!(:scrape).and_return(page_content)
      results = scraper.build_results_hash

      results.should be_kind_of Hash
      results.keys.length.should eq 3
      results.keys.should include(:username)
      results.keys.should include(:song_id)
      results.keys.should include(:audio_id)
    end
  end

  describe '#build_link' do
    it 'builds a link from a tumblr blog post' do
      link = 'http://kaepop.tumblr.com/post/11352761077/bubble-tea-river-flows-in-you-sung-by'
      page_content = %q(<div class="audioplayer"><div style="margin: 5px 0 0 5px; width: 18px; overflow:hidden;" id="11352761077"><span id="audio_player_11352761077">[<a href="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" target="_blank">Flash 9</a> is required to listen to audio.]</span><script type="text/javascript">replaceIfFlash(9,"audio_player_11352761077",'\x3cdiv class=\x22audio_player\x22\x3e<embed type="application/x-shockwave-flash" src="http://assets.tumblr.com/swf/audio_player_black.swf?audio_file=http://www.tumblr.com/audio_file/kaepop/11352761077/tumblr_lsvm9fk2Qw1qcup2x&color=FFFFFF&logo=soundcloud" height="27" width="207" quality="best" wmode="opaque"></embed>\x3c/div\x3e')</script></div></div>)
      expected_return = %q(http://www.tumblr.com/audio_file/kaepop/11352761077/tumblr_lsvm9fk2Qw1qcup2x?plead=please-dont-download-this-or-our-lawyers-wont-let-us-host-audio)

      scraper = Scraper.new(link)
      scraper.stub!(:scrape).and_return(page_content)
      results = scraper.build_link
      results.should eq expected_return
    end
  end

end
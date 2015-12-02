require_relative 'config'
require_relative 'tweet'


puts "Mensagem bonitinha de entrada"
teams = YAML.load_file("teams.yml")

puts "Enter away team:"
while true
  away_team = gets.strip

  if teams.keys.any?{|k| k =~ /#{away_team}/i}
    if teams.keys.select{|k| k =~ /#{away_team}/i}.count > 1
      puts "Did you mean?"
      teams.keys.select{|k| k =~ /#{away_team}/i}.each do |k,v|
        puts "\t#{k}"
      end
      puts "\nEnter away team:"
    else
      key_team1 = teams.keys.select{|k| k =~ /#{away_team}/i}.first
      break
    end
  else
    puts "Error! Team not found!"
    puts "\nEnter away team:"
  end
end

puts "Enter home team:"
while true
  home_team = gets.strip

  if teams.keys.any?{|k| k =~ /#{home_team}/i}
    if teams.keys.select{|k| k =~ /#{home_team}/i}.count > 1
      puts "Did you mean?"
      teams.keys.select{|k| k =~ /#{home_team}/i}.each do |k,v|
        puts "\t#{k}"
      end
      puts "\nEnter home team:"
    else
      key_team2 = teams.keys.select{|k| k =~ /#{home_team}/i}.first
      break
    end
  else
    puts "Error! Team not found!"
    puts "\nEnter home team:"
  end
end

hashtag = "#{teams[key_team1]}vs#{teams[key_team2]}"

account_away_team = CLIENT.user_search(key_team1, count: 10).delete_if{|x| not (x.name =~ /#{key_team1}/i)}.sort_by{|x| -x.followers_count}.first
account_home_team = CLIENT.user_search(key_team2, count: 10).delete_if{|x| not (x.name =~ /#{key_team2}/i)}.sort_by{|x| -x.followers_count}.first

query = "##{hashtag} from:NFL -rt"
hashtag_results = CLIENT.search(query, lang: :en).to_a
home_results = CLIENT.search("from:#{account_home_team.screen_name} -rt", lang: :en, since: "2015-11-30" , untli: "2015-12-02" ).to_a
away_results = CLIENT.search("from:#{account_away_team.screen_name} -rt", lang: :en, since: "2015-11-30" , untli: "2015-12-02").to_a

timeline = []
hashtag_results.each do |result|
  timeline << Tweet.new(result, 0)
end

home_results.each do |result|
  timeline << Tweet.new(result, 1)
end

away_results.each do |result|
  timeline << Tweet.new(result, 2)
end

timeline.delete_if{|x| not (Tweet::KEYWORDS.any?{|w| x.text.downcase.include?(w)})}
timeline.sort_by!{|tweet| tweet.date.to_i}

timeline.each do |tweet|
  puts tweet.text.blue if tweet.color == 0
  puts tweet.text.yellow if tweet.color == 1
  puts tweet.text if tweet.color == 2
end

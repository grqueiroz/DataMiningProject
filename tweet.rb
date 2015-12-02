class Tweet
  attr_reader :text, :date, :color

  KEYWORDS  = [
      "touchdown", " td ", "field goal", " fg ", "safety",
      "interception", "fumble", "punt", "sack", " int ", "block", "pick", "drop",
      "kickoff", "kick off", "q1", "q2", "q3", "q4", "quarter", "halftime", " ht ", "injury", "penalty", "flag",
      "challenge", "overtime", "final", "first", "second", "third",  "fourth"
      ]

  def initialize tweet, color
    @text = tweet.text
    @weight = ""
    @date = tweet.created_at
    @color = color

    set_weight(tweet)
  end

  def set_weight(tweet)

  end
end

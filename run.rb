module UserTimeout
	attr_accessor  :lastPlayed
end

Songs = {
	"shuffle" => [
		"Song Title.mp3",
	],
	"users name" => []
}

# ::RBNACL_LIBSODIUM_GEM_LIB_PATH = "C:/libsodium.dll"
require 'discordrb'
require 'yaml'

begin

	config = YAML.load_file("config.yml")

	Bot = Discordrb::Bot.new token: config["token"], client_id: config["client-id"]

	$lastPlayed = Time.now - 50

	Bot.voice_state_update(from: not!(["Theme Song Bot", "Rythm"])) do |event|
		event.user.extend(UserTimeout)
		# Minute delay for the individual user switching, 15 seconds for any user, to prevent spamming
		if (!event.user.lastPlayed or Time.now - event.user.lastPlayed > 60) and Time.now - $lastPlayed > 15 and !(event.old_channel.eql? event.channel)
			$bot_voice = Bot.voice_connect(event.channel)
			$lastPlayed = Time.now
			event.user.lastPlayed = Time.now
			if Songs[event.user.name]
					$bot_voice.play_file("Themes/#{Songs[event.user.name].sample}")
			else
				$bot_voice.play_file("Themes/#{Songs['shuffle'].sample}")
			end
			$bot_voice.destroy
		end
	end

	Bot.run()
rescue SystemExit, Interrupt => e
	#Shutdown
	puts "Shutting Down"
	Bot.stop
end
# Theme-Song-Bot
A Discord Bot that plays a theme song when a user connects to a voice channel

## Usage
Add any audio files (works best under 10 seconds) into a folder named 'Themes' in the cloned directory. In the 'Songs' object, list the main username (not their nickname) as the hash key, and an array of all their theme titles as the value. For people without any specific theme(s), whatever is listed in 'shuffle' will be chosen at random.
```
	gem install discordrb
	gem install yaml
	ruby run.rb
```

from pygame import mixer

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Initializations (eventually set these in main)
default_mixer_volume = 0.75

global_audio_path = "/home/liamroy/Documents/PHD/audio/"
sound_library = "sonification_library_V1/sounds_repeated/"
audio_extension = ".mp3"


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


def Get_Valence_Arousal():
	# Get user inputted valence & arousal

	user_selected_valence = 0
	user_selected_arousal = 0

	while True:
		try:
			user_selected_valence = int(input("Enter a valence integer -2 to 2: "))
		except ValueError:
			print("Please enter a valid valence integer -2 to 2")
			continue
		if user_selected_valence >= -2 and user_selected_valence <= 2:
			print(f'You entered: {user_selected_valence}')
			break
		else:
			print('The valence integer must be in the range -2 to 2')


	while True:
		try:
			user_selected_arousal = int(input("Enter an arousal integer 0 to 4: "))
		except ValueError:
			print("Please enter a valid arousal integer 0 to 4")
			continue
		if user_selected_arousal >= 0 and user_selected_arousal <= 4:
			print(f'You entered: {user_selected_arousal}')
			break
		else:
			print('The arousal integer must be in the range 0 to 4')
	return user_selected_valence, user_selected_arousal


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


def Get_MP3_Path(valence, arousal):
	# Gets the MP3 path based on the valence & arousal inputs

	if valence < 0:
		valence_str = "n" + str(abs(valence))
	else:
		valence_str = str(valence)

	if arousal < 0:
		arousal_str = "n" + str(abs(arousal))
	else:
		arousal_str = str(arousal)

	MP3_path = global_audio_path + sound_library + "lib1_va_" + valence_str + "_" + arousal_str + audio_extension

	return MP3_path


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def Play_MP3(MP3_file_path, mixer_volume=default_mixer_volume):

	#Instantiate mixer
	mixer.init()

	#Load audio file
	mixer.music.load(MP3_file_path)

	print("music started playing....")

	#Set preferred volume
	mixer.music.set_volume(mixer_volume)

	#Play the music
	mixer.music.play()

	#Infinite loop
	while True:
		print("------------------------------------------------------------------------------------")
		print("Press 'p' to pause the music")
		print("Press 'r' to resume the music")
		print("Press 'e' to exit the program")

		#take user input
		userInput = input(" ")
		
		if userInput == 'p':

			# Pause the music
			mixer.music.pause()	
			print("music is paused....")
		elif userInput == 'r':

			# Resume the music
			mixer.music.unpause()
			print("music is resumed....")
		elif userInput == 'e':

			# Stop the music playback
			mixer.music.stop()
			print("music is stopped....")
			break

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# RESOURCES:
# PyGame Installation:		https://www.pygame.org/wiki/GettingStarted 
# PyGame Documentation:		https://www.pygame.org/docs/ref/music.html  
# Play Sound w/ PyGame:		https://www.educative.io/answers/how-to-play-an-audio-file-in-pygame 

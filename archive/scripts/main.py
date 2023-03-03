# IMPORTS
import numpy as np
import audio_control
import ucb1_algorithm as ucb1
import misc_helpers
import random

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# INITIALIZATIONS 

budget = 40						# number of total iterations 

all_states = ["Progressing \t- robot is working and doesn't need help", "Successful \t- robot has completed it's task", "Stuck      \t- robot needs your help", "None of the above"]
num_of_states = len(all_states) - 1 # Adding a minus 1 since the last state in "all_states" is "none of the above"

current_state_index = 0 		# Current actual state of the robot
print(f"\n(Hidden) ~ Current actual state of robot: {current_state_index}\n")

param_disc = ucb1.param_disc 	# number of discretized regions for each param --> i.e. if equals 3 then (0, 1, 2)
								# this must align with the discretization for selected sound library

# Creates an array of size (N x N x N) where N = number of discretized regions
sound_obj_array = np.ndarray((param_disc, param_disc, param_disc),dtype=np.object)

for param_1_range in range(param_disc):
	for param_2_range in range(param_disc):
		for param_3_range in range(param_disc):
			sound_obj_array[param_1_range, param_2_range, param_3_range] = audio_control.audio_object(param_1_range, param_2_range, param_3_range, budget)


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MAIN

if __name__ == "__main__":

	print(num_of_states)

	# Initialize time_step to zero
	time_step = 0

	# Initialize to center of mapping
	param_1_idx = 1 
	param_2_idx = 1
	param_3_idx = 1


	for i in range(0, budget):

		if time_step == 0:
			param_1_idx = 1 
			param_2_idx = 1
			param_3_idx = 1
		else:
		# Select new params
			param_1_idx, param_2_idx, param_3_idx = ucb1.action_selection()

		time_step += 1
		
		print("----------------------------------------------------------------")
		print("----------------------------------------------------------------")
		print()
		print(f"(Hidden) ~ New Param INDICES: \nP1: {param_1_idx} (Beats per Minute - BPM) \nP2: {param_2_idx} (Beeps per Loop - BPL) \nP3: {param_3_idx} (Amplitude of Pitch Change)\n")

		# Play the desired mp3 file, probe user based on sound, then update the Q-Value look-up table
		ucb1.update_loop(sound_obj_array[param_1_idx, param_2_idx, param_3_idx], all_states, current_state_index, time_step)
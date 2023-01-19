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
all_states = ["Progressing", "Successful", "Requires Assistance", "Unsure"]

current_state_index = 0 		# Current actual state of the robot
print(f"\n(Hidden) ~ Current actual state of robot: {current_state_index}\n")

param_disc = ucb1.param_disc 	# number of discretized regions for each param --> i.e. if equals 5 then (0, 1, 2, 3, 4)

sound_obj_array = np.ndarray((param_disc, param_disc),dtype=np.object)

for param_1_range in range(param_disc):
	for param_2_range in range(param_disc):
		sound_obj_array[param_1_range, param_2_range] = audio_control.audio_object(param_1_range, param_2_range, budget)
		# print(f"Entering object: first_param {param_1_range} // second_param: {param_2_range}")


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MAIN

if __name__ == "__main__":

	# Initialize time_step to zero
	time_step = 0

	# Initialize to center of mapping
	param_1_idx = 2 
	param_2_idx = 2

	for i in range(0, budget):

		if time_step == 0:
			param_1_idx = 2 
			param_2_idx = 2
		else:
		# Select new params
			param_1_idx, param_2_idx = ucb1.action_selection()

		time_step += 1
		
		print("----------------------------------------------------------------")
		print("----------------------------------------------------------------")
		print()
		print(f"(Hidden) ~ New Param INDICES: \nP1: {param_1_idx} (Amplitude of Pitch Change) \nP2: {param_2_idx} (Number of Beeps per Loop)\n")

		# Play the desired mp3 file, probe user based on sound, then update the Q-Value look-up table
		ucb1.update_loop(sound_obj_array[param_1_idx, param_2_idx], all_states, current_state_index, time_step)
# IMPORTS
import numpy as np
import audio_control
import ucb1_algorithm as ucb1
import misc_helpers
import random

print(random.randint(3, 9))

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# INITIALIZATIONS 

budget = 4						# number of total iterations 
param_disc = ucb1.param_disc 	# number of discretized regions for each param --> i.e. if equals 5 then (0, 1, 2, 3, 4)

all_states = ["Progressing", "Successful", "Requires Assistance"]
current_state_index = 0 		# Current actual state of the robot


sound_obj_array = np.ndarray((param_disc, param_disc),dtype=np.object)

for param_1_range in range(param_disc):
	for param_2_range in range(param_disc):
		print(f"Entering object: first_param {param_1_range} // second_param: {param_2_range}")
		sound_obj_array[param_1_range, param_2_range] = audio_control.audio_object(param_1_range, param_2_range)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MAIN

if __name__ == "__main__":
	print()

	for i in range(0, budget):
		print("----------------------------------------------------------------")
		print("----------------------------------------------------------------")
		print()

		# Choose index of sound to try - currently random policy
		param_1_idx = random.randint(0, 4)
		param_2_idx = random.randint(0, 4)
		print(f"New Param Indices: \nP1: {param_1_idx} \nP2: {param_2_idx}\n")

		# Play the desired mp3 file, probe user based on sound, then update the Q-Value look-up table
		ucb1.update_loop(sound_obj_array[param_1_idx, param_2_idx], all_states, current_state_index)

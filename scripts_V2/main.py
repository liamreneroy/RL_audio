# IMPORTS
import numpy as np
import audio_control
import ucb1_algorithm as ucb1
import time
import misc_helpers
import random

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# INITIALIZATIONS 

budget = 40						# number of total iterations 

state_descriptions = ["Progressing \t- robot is working and doesn't need help", "Successful \t- robot has completed it's task", "Stuck      \t- robot needs your help", "None of the above"]
num_of_states = len(state_descriptions) - 1 # Adding a minus 1 since the last state in "state_descriptions" is "none of the above"


current_state_index = 0 		# Current actual state of the robot - change this to fluctuate during study
print("(Hidden):")
print(f"Current actual state of robot: {current_state_index}\n")


# Create an array of size (N x N x N) where N = number of discretized regions
# number of discretized regions for each param --> i.e. if equals 3 then (0, 1, 2)
# ** must align with the discretization for selected sound library
sound_obj_array = np.ndarray((ucb1.param_disc, ucb1.param_disc, ucb1.param_disc),dtype=np.object)


for param_1_range in range(ucb1.param_disc):
	for param_2_range in range(ucb1.param_disc):
		for param_3_range in range(ucb1.param_disc):
			sound_obj_array[param_1_range, param_2_range, param_3_range] = audio_control.audio_object(param_1_range, param_2_range, param_3_range, budget)


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MAIN

if __name__ == "__main__":

	# Initialize time_step to zero
	time_step = 0

	# Initialize to center of mapping
	param_1_idx = 1 
	param_2_idx = 1
	param_3_idx = 1

	states_array = np.ndarray(num_of_states, dtype=np.object)

	for state_idx in range(num_of_states):
		states_array[state_idx] = ucb1.robot_state(state_idx, state_descriptions[state_idx], ucb1.param_disc)

	# print("test section\n")
	# print(states_array[2].description)
	# print("test section over\n")

	for i in range(0, budget):

		if time_step == 0:
			param_1_idx = 1 
			param_2_idx = 1
			param_3_idx = 1
		else:
		# Select new params
			param_1_idx, param_2_idx, param_3_idx = states_array[current_state_index].action_selection()

		time_step += 1
		
		print("\n----------------------------------------------------------------")
		print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
		print("----------------------------------------------------------------\n")
		print("(Hidden):")
		print(f"New Param INDICES: \nP1: {param_1_idx} (Beats per Minute - BPM) \nP2: {param_2_idx} (Beeps per Loop - BPL) \nP3: {param_3_idx} (Amplitude of Pitch Change)\n")

		# Play the desired mp3 file, probe user based on sound, then update the Q-Value look-up table
		
		# Probe user for perceived state & confidence in their response
		probed_state_index, probed_confidence = sound_obj_array[param_1_idx, param_2_idx, param_3_idx].probe(state_descriptions)

		# Update N for audio obj
		sound_obj_array[param_1_idx, param_2_idx, param_3_idx].update()
		
		# Calculate uncertainty signal (U_t) based on N and time_step
		uncertainty_signal = sound_obj_array[param_1_idx, param_2_idx, param_3_idx].uncertainty(time_step)

		# For each state, calculate the respective reward signal (R)
		for state_idx in range(num_of_states):
			if probed_state_index == state_idx:
				correct_multiplier = 1.0
			elif probed_state_index != state_idx:
				correct_multiplier = -1.0

			# This is the reward signal R
			reward_signal = correct_multiplier * probed_confidence

			# Calculate new Q_t = {[(1 - 1/n) * Q_t-1] + [(1/n) * R]} + U_t   ~  UCB1 algorithm update equation
			# Takes the mean of previously observed reward and new reward, adding on an uncertainty term
			Q_value = ((1 - 1.0/sound_obj_array[param_1_idx, param_2_idx, param_3_idx].n) * states_array[state_idx].action_value_lookup[param_1_idx, param_2_idx, param_3_idx] + (1.0/sound_obj_array[param_1_idx, param_2_idx, param_3_idx].n) * reward_signal) + uncertainty_signal

			# Update value in lookup table for state S with new Q_t
			# Added an np.clip so that the mix/max Q-Value in the table cant exceed -10 to +10
			states_array[state_idx].action_value_lookup[param_1_idx, param_2_idx, param_3_idx] = np.clip(Q_value, -10, 10)

			print("\n\n----------------------------------------------------------------\n")
			print("(Hidden):")
			print(f"Uncertainty_signal (U):\t {uncertainty_signal}")
			print(f"Reward_signal (R):\t {reward_signal}")
			print(f"New action value (Q):\t {Q_value}")
			print(f"Q-table after update for state {state_idx}:\n")
			print(states_array[state_idx].action_value_lookup)
	
			time.sleep(2) # Put here to make UI a bit nicer 
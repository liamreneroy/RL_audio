# IMPORTS
import numpy as np
import time

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# INITIALIZATIONS 

param_disc = 3 # number of discretized regions for each param --> i.e. if equals 5 then (0, 1, 2, 3, 4)

# Initialize all Q-Values to max reward (optimism in the face of uncertainty)
Q_value_lookup = np.ones((param_disc, param_disc, param_disc)) * 10.0 # Arbitrary initialization

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# STAND-ALONE FUNCTIONS

def update_loop(loop_object, all_states, current_state_index, time_step):

	loop_object.probe(all_states, current_state_index)
	loop_object.update()
	
	Q_value_lookup[loop_object.param_1, loop_object.param_2, loop_object.param_3] = np.clip(loop_object.sample(time_step), -10, 10)
	# Added an np.clip so that the mix/max Q-Value in the table cant exceed -10 to +10

	print("(hidden) ~ Q-Value lookup table after update:\n\n", Q_value_lookup)
	print()

	time.sleep(2.5) # Put here to make UI a bit nicer 


def randargmax(b,**kw):
  """ a random tie-breaking argmax"""
  return np.argmax(np.random.random(b.shape) * (b==b.max()), **kw)


def action_selection():
	max_action_index = np.unravel_index(randargmax(Q_value_lookup), Q_value_lookup.shape)
	param_1_idx = max_action_index[0]
	param_2_idx = max_action_index[1]
	param_3_idx = max_action_index[2]


	# print("max_action_index:", max_action_index)
	# print("params_idx", param_1_idx, param_2_idx)
	# print()
	return param_1_idx, param_2_idx, param_3_idx

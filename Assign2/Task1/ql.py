import numpy as np
import random

# Define parameters
eta = 0.1     # Learning rate
gamma = 0.95  # Discount factor
epsilon = 0.1 # Exploration rate
num_episodes = 10000

# Define Gridworld parameters
states = 35  # Classic map (5x7 grid)
actions = 4  # Up, Down, Left, Right

# Initialize Q-table
Q = np.zeros((states, actions))

# Define action mapping
UP, DOWN, LEFT, RIGHT = 0, 1, 2, 3

# Define environment
goal_state = 12
danger_states = set()
walls = {11, 13, 16, 17, 18}
reward_goal = 1
reward_default = 0

# State transition function
def get_next_state(state, action):
    row, col = divmod(state, 7)
    if action == UP and row > 0:
        next_state = state - 7
    elif action == DOWN and row < 4:
        next_state = state + 7
    elif action == LEFT and col > 0:
        next_state = state - 1
    elif action == RIGHT and col < 6:
        next_state = state + 1
    else:
        next_state = state  # Invalid move, stay in place

    if next_state in walls:
        return state  # Can't move into a wall
    return next_state

# Define a function to calculate and print Q-value update step for a specific state-action pair
def calculate_q_value(state, action, reward, next_state):
    max_future_q = np.max(Q[next_state])  # Best future Q-value
    old_q_value = Q[state, action]  # Old Q-value
    new_q_value = old_q_value + eta * (reward + gamma * max_future_q - old_q_value)  # Updated Q-value
    return old_q_value, new_q_value

# Training loop
for _ in range(num_episodes):
    state = random.randint(0, states - 1)
    while state != goal_state:
        if random.uniform(0, 1) < epsilon:
            action = random.choice([UP, DOWN, LEFT, RIGHT])
        else:
            action = np.argmax(Q[state])

        next_state = get_next_state(state, action)
        reward = reward_goal if next_state == goal_state else reward_default

        # Only print for state 2 and action DOWN
        if state == 2 and action == DOWN:
            old_q, new_q = calculate_q_value(state, action, reward, next_state)
            print(f"State 2, Action DOWN: Old Q-value: {old_q:.4f}, Reward: {reward}, Next State: {next_state}, Max Future Q: {np.max(Q[next_state]):.4f}, New Q-value: {new_q:.4f}")

        # Update Q-value for this state-action pair
        Q[state, action] += eta * (reward + gamma * np.max(Q[next_state]) - Q[state, action])
        state = next_state

# Output the final true value of moving Down from state 2
print("Q*(State 2, Down):", Q[2, DOWN])

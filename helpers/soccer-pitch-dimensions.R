# pitch dimensions for ggsoccer plot
# the default pitch dimensions are scaled to be 150 x 100
# our pitch dimensions were scaled to be 100 x 60
# therefore we need to divide all widths by 1.5 and heights by 1.67

pitch_custom <- list(
  length = 150/1.5,
  width = 100/1.67,
  penalty_box_length = 25/1.5,
  penalty_box_width = 50/1.67,
  six_yard_box_length = 8/1.5,
  six_yard_box_width = 26/1.67,
  penalty_spot_distance = 16/1.5,
  goal_width = 12/1.67,
  origin_x = 0,
  origin_y = 0
)
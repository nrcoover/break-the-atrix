extends Node


const npc_speed: float = 120.0
const npc_search_speed: float = npc_speed * 1.4
const npc_chase_speed: float = npc_speed * 1.7

const player_speed_multiplier: float = 2.0
const player_speed: float = npc_speed * player_speed_multiplier
const bullet_speed: float = player_speed * 2

const npc_field_of_view: float = 60
const npc_searching_field_of_view: float = 90
const npc_chasing_field_of_view: float = 120
